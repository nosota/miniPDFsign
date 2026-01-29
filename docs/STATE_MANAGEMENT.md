# State Management

This document describes the state management architecture using Riverpod.

## Provider Organization

Providers are organized in `lib/presentation/providers/`:

```
providers/
├── data_source_providers.dart    # Data source instances
├── repository_providers.dart     # Repository instances
├── shared_preferences_provider.dart
├── file_picker_provider.dart
├── recent_files_provider.dart
├── locale_preference_provider.dart
├── editor/                       # Editor-related state
│   ├── placed_images_provider.dart
│   ├── editor_selection_provider.dart
│   ├── document_dirty_provider.dart
│   ├── file_source_provider.dart
│   └── ...
├── pdf_viewer/                   # PDF viewing state
│   ├── pdf_document_provider.dart
│   ├── pdf_page_cache_provider.dart
│   └── ...
├── sidebar/                      # Image library state
│   └── sidebar_images_provider.dart
└── onboarding/                   # Onboarding state
    └── onboarding_provider.dart
```

## Provider Categories

### Infrastructure Providers

These provide core dependencies:

| Provider | Type | Purpose |
|----------|------|---------|
| `sharedPreferencesProvider` | `Provider` | Pre-initialized SharedPreferences |
| `isarProvider` | `Provider` | Isar database instance |

**Note:** Both must be overridden in `main()` with pre-loaded instances.

### Repository Providers

Dependency injection for repositories:

```dart
@Riverpod(keepAlive: true)
PdfDocumentRepository pdfDocumentRepository(ref) {
  final dataSource = ref.watch(pdfDataSourceProvider);
  return PdfDocumentRepositoryImpl(dataSource);
}
```

### PDF Viewer Providers

| Provider | State Type | Purpose |
|----------|-----------|---------|
| `pdfDocumentProvider` | `PdfViewerState` | Document loading, zoom, navigation |
| `pdfPageCacheProvider` | `PdfPageCache` | LRU cache for rendered pages |
| `pdfPageImageProvider` | `Future<Uint8List>` | Renders single page |
| `visiblePagesProvider` | `Set<int>` | Tracks visible page range |

**PdfViewerState** (Freezed union):
- `initial()` - No document
- `loading(filePath)` - Loading in progress
- `loaded(document, scale, currentPage, ...)` - Ready
- `error(message)` - Load failed
- `passwordRequired(filePath)` - Needs password

### Editor Providers

| Provider | State Type | Purpose |
|----------|-----------|---------|
| `placedImagesProvider` | `List<PlacedImage>` | Images placed on PDF |
| `editorSelectionProvider` | `String?` | Selected image ID |
| `documentDirtyProvider` | `bool` | Unsaved changes flag |
| `fileSourceProvider` | `FileSourceType` | Where file was opened from |
| `pointerOnObjectProvider` | `Map<int, String>` | Multi-touch tracking |

### Sidebar Providers

| Provider | State Type | Purpose |
|----------|-----------|---------|
| `sidebarImagesProvider` | `Stream<List<SidebarImage>>` | Image library with Isar streaming |

### Preference Providers

| Provider | State Type | Persistence |
|----------|-----------|-------------|
| `localePreferenceProvider` | `String?` | SharedPreferences |
| `sizeUnitPreferenceProvider` | `SizeUnit` | SharedPreferences |
| `onboardingProvider` | `Set<OnboardingStep>` | SharedPreferences |

## Provider Patterns

### keepAlive Pattern

Use `@Riverpod(keepAlive: true)` for providers that should persist:

```dart
@Riverpod(keepAlive: true)
class PlacedImages extends _$PlacedImages {
  @override
  List<PlacedImage> build() => [];
  // ...
}
```

**When to use:**
- Document state (survives widget rebuilds)
- Placed images (persists during zoom/scroll)
- Dirty state tracking
- Repository instances

### Async Notifier Pattern

For async data with mutations:

```dart
@Riverpod(keepAlive: true)
class RecentFiles extends _$RecentFiles {
  @override
  Future<List<RecentFile>> build() async {
    final repository = ref.watch(recentFilesRepositoryProvider);
    final result = await repository.getRecentFiles();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (files) => files,
    );
  }

  Future<void> addFile(RecentFile file) async {
    final repository = ref.read(recentFilesRepositoryProvider);
    await repository.addRecentFile(file);
    ref.invalidateSelf(); // Refresh
  }
}
```

### Stream Notifier Pattern

For reactive database updates:

```dart
@riverpod
class SidebarImages extends _$SidebarImages {
  @override
  Stream<List<SidebarImage>> build() {
    final repository = ref.watch(sidebarImageRepositoryProvider);
    return repository.watchImages();
  }
}
```

### Simple State Pattern

For basic UI state:

```dart
final permissionRetryProvider = StateProvider<bool>((ref) => false);
```

## State Updates

### Immutable Updates

Always create new state objects:

```dart
void addImage(PlacedImage image) {
  state = [...state, image];
}

void removeImage(String id) {
  state = state.where((img) => img.id != id).toList();
}

void updateImage(PlacedImage updated) {
  state = state.map((img) => img.id == updated.id ? updated : img).toList();
}
```

### Batch Updates

For multiple related changes:

```dart
void transformImage(String id, {Offset? position, Size? size, double? rotation}) {
  state = state.map((img) {
    if (img.id != id) return img;
    return img.copyWith(
      position: position ?? img.position,
      size: size ?? img.size,
      rotation: rotation ?? img.rotation,
    );
  }).toList();
}
```

## Provider Dependencies

### Dependency Graph

```
sharedPreferencesProvider ←── localePreferenceProvider
                          ←── sizeUnitPreferenceProvider
                          ←── onboardingProvider
                          ←── recentFilesLocalDataSourceProvider

isarProvider ←── sidebarImageLocalDataSourceProvider

pdfDataSourceProvider ←── pdfDocumentRepositoryProvider ←── pdfDocumentProvider
                                                        ←── pdfPageImageProvider

sidebarImageRepositoryProvider ←── sidebarImagesProvider

placedImagesProvider ←── (used by PlacedImagesLayer, PdfDropTarget)
editorSelectionProvider ←── (used by PlacedImageWidget, PdfViewer)
```

### Reading vs Watching

```dart
// In build() - reactive, rebuilds on change
final state = ref.watch(someProvider);

// In callbacks - one-time read
ref.read(someProvider.notifier).doSomething();

// For side effects
ref.listen(someProvider, (prev, next) {
  if (next.hasError) showErrorSnackbar();
});
```

## Testing Providers

```dart
test('should add placed image', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);

  container.read(placedImagesProvider.notifier).addImage(
    sourceImageId: 'img-1',
    imagePath: '/path/to/image.png',
    pageIndex: 0,
    position: const Offset(100, 100),
    size: const Size(200, 150),
  );

  final images = container.read(placedImagesProvider);
  expect(images.length, 1);
  expect(images.first.pageIndex, 0);
});

test('with mocked repository', () {
  final mockRepo = MockPdfDocumentRepository();
  when(mockRepo.openDocument(any)).thenAnswer(
    (_) async => Right(mockDocument),
  );

  final container = ProviderContainer(
    overrides: [
      pdfDocumentRepositoryProvider.overrideWithValue(mockRepo),
    ],
  );

  // Test with mocked dependency
});
```

## Error Handling

All repository calls use Either pattern:

```dart
Future<void> openDocument(String filePath) async {
  state = PdfViewerState.loading(filePath: filePath);

  final result = await _repository.openDocument(filePath);

  state = result.fold(
    (failure) => failure.maybeMap(
      passwordRequired: (_) => PdfViewerState.passwordRequired(filePath: filePath),
      orElse: () => PdfViewerState.error(message: failure.message),
    ),
    (document) => PdfViewerState.loaded(document: document, scale: 1.0, ...),
  );
}
```
