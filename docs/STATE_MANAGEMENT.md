# State Management

This document describes the state management architecture using Riverpod.

## Provider Organization

Providers are organized in `lib/presentation/providers/`:

```
providers/
├── data_source_providers.dart       # Data source instances
├── repository_providers.dart        # Repository & service instances
├── shared_preferences_provider.dart # SharedPreferences singleton
├── native_settings_provider.dart    # iOS UserDefaults / Android prefs bridge
├── file_picker_provider.dart        # File selection
├── recent_files_provider.dart       # Recent files list
├── locale_preference_provider.dart  # Locale selection (60+ languages)
├── editor/                          # Editor-related state
│   ├── placed_images_provider.dart
│   ├── editor_selection_provider.dart
│   ├── document_dirty_provider.dart
│   ├── file_source_provider.dart
│   ├── original_pdf_provider.dart
│   ├── pdf_save_service_provider.dart
│   ├── pdf_share_service_provider.dart
│   ├── pointer_on_object_provider.dart
│   └── size_unit_preference_provider.dart
├── pdf_viewer/                      # PDF viewing state
│   ├── pdf_document_provider.dart
│   ├── pdf_page_cache_provider.dart
│   ├── pdf_viewer_state.dart
│   └── permission_retry_provider.dart
├── viewer_session/                  # Session-scoped state isolation
│   ├── viewer_session.dart
│   ├── viewer_session_provider.dart
│   └── viewer_session_scope.dart
├── sidebar/                         # Image library state
│   └── sidebar_images_provider.dart
├── services/                        # Service providers
│   └── image_to_pdf_service_provider.dart
└── onboarding/                      # Onboarding state
    └── onboarding_provider.dart
```

## Provider Categories

### Infrastructure Providers

These provide core dependencies:

| Provider | Type | Purpose |
|----------|------|---------|
| `sharedPreferencesProvider` | `Provider` | Pre-initialized SharedPreferences |
| `isarProvider` | `Provider` | Isar database instance |
| `nativeSettingsProvider` | `StateNotifierProvider` | iOS UserDefaults / Android SharedPreferences bridge |

**Note:** `sharedPreferencesProvider`, `isarProvider`, and `nativeSettingsProvider` must be overridden in `main()` with pre-loaded instances.

### Repository & Service Providers

Dependency injection for repositories and services:

| Provider | Type | keepAlive |
|----------|------|-----------|
| `pdfDocumentRepositoryProvider` | `Provider` | yes |
| `filePickerRepositoryProvider` | `Provider` | no |
| `sidebarImageRepositoryProvider` | `Provider` | yes |
| `recentFilesRepositoryProvider` | `Provider` | yes |
| `imageStorageServiceProvider` | `Provider` | yes |
| `imageValidationServiceProvider` | `Provider` | yes |
| `imagePickerServiceProvider` | `Provider` | yes |
| `imageNormalizationServiceProvider` | `Provider` | yes |
| `backgroundDetectionServiceProvider` | `Provider` | yes |
| `backgroundRemovalServiceProvider` | `Provider` | yes |
| `fileBookmarkServiceProvider` | `Provider` | yes |
| `imageToPdfServiceProvider` | `Provider` | no |

```dart
@Riverpod(keepAlive: true)
PdfDocumentRepository pdfDocumentRepository(ref) {
  final dataSource = ref.watch(pdfDataSourceProvider);
  return PdfDocumentRepositoryImpl(dataSource);
}
```

### Viewer Session Providers

Session-scoped family providers that ensure **complete state isolation** between viewer instances. Each provider takes a `sessionId` parameter.

| Provider | State Type | Purpose |
|----------|-----------|---------|
| `viewerSessionsProvider` | `Set<String>` | Tracks active session IDs |
| `sessionPdfDocumentProvider(id)` | `PdfViewerState` | Document loading, zoom, navigation |
| `sessionFileSourceProvider(id)` | `SessionFileSourceState` | Save behavior (overwrite, share, save-to-docs) |
| `sessionDocumentDirtyProvider(id)` | `bool` | Unsaved changes flag |
| `sessionPlacedImagesProvider(id)` | `List<PlacedImage>` | Images placed on PDF |
| `sessionEditorSelectionProvider(id)` | `String?` | Selected image ID |
| `sessionPermissionRetryProvider(id)` | `bool` | Permission retry state |

**Session lifecycle:**
1. `PdfViewerScreen` creates `ViewerSession` with unique ID
2. `ViewerSessionScope` InheritedWidget provides session ID to descendants
3. Child widgets access session ID via `ViewerSessionScope.of(context)`
4. On dispose, `ViewerSessions.unregisterSession()` invalidates all family providers

```dart
// Access session ID in widgets
final sessionId = ViewerSessionScope.of(context);

// Use session-scoped provider
final docState = ref.watch(sessionPdfDocumentProvider(sessionId));
```

### PDF Viewer Providers (Legacy / Shared)

| Provider | State Type | Purpose |
|----------|-----------|---------|
| `pdfDocumentProvider` | `PdfViewerState` | Document loading, zoom, navigation |
| `pdfPageCacheProvider` | `PdfPageCache` | LRU cache for rendered pages |
| `pdfPageImageProvider` | `Future<Uint8List>` | Renders single page |

**PdfViewerState** (Freezed union):
- `initial()` — No document
- `loading(filePath)` — Loading in progress
- `converting(imageCount)` — Converting images to PDF
- `loaded(document, scale, isFitWidth, fitWidthScale, currentPage, viewportWidth, viewportHeight)` — Ready
- `error(message, filePath?)` — Load failed
- `passwordRequired(filePath)` — Needs password

**ZoomPreset** enum: fitWidth, 50%, 75%, 100%, 125%, 150%, 200%, 300%, 400%, 500%

**ZoomConstraints**: minScale 0.1, maxScale 5.0, step 0.1

### Editor Providers

| Provider | State Type | Purpose |
|----------|-----------|---------|
| `placedImagesProvider` | `List<PlacedImage>` | Images placed on PDF |
| `editorSelectionProvider` | `String?` | Selected image ID |
| `documentDirtyProvider` | `bool` | Unsaved changes flag |
| `fileSourceProvider` | `FileSourceType` | Where file was opened from |
| `pointerOnObjectProvider` | `Map<int, String>` | Multi-touch tracking |
| `originalPdfProvider` | `OriginalPdfStorage` | Original PDF bytes |
| `pdfSaveServiceProvider` | `PdfSaveService` | PDF saving |
| `pdfShareServiceProvider` | `PdfShareService` | PDF sharing |

**FileSourceType** enum:
- `filesApp` — iOS "Open In", can overwrite original
- `filePicker` — In-app picker, use Share Sheet
- `recentFile` — Recent files list, use Share Sheet
- `convertedImage` — Image converted to PDF, save to Documents

### Sidebar Providers

| Provider | State Type | Purpose |
|----------|-----------|---------|
| `sidebarImagesProvider` | `Stream<List<SidebarImage>>` | Image library with Isar streaming |

### Preference Providers

| Provider | State Type | Persistence |
|----------|-----------|-------------|
| `localePreferenceProvider` | `String?` | SharedPreferences / NativeSettings |
| `sizeUnitPreferenceProvider` | `SizeUnit` | SharedPreferences / NativeSettings |
| `onboardingProvider` | `Set<OnboardingStep>` | SharedPreferences |
| `nativeSettingsProvider` | `NativeSettings` | iOS UserDefaults / Android SharedPreferences |

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

### Family Provider Pattern (Session-Scoped)

For state that must be isolated per viewer session:

```dart
@riverpod
class SessionPlacedImages extends _$SessionPlacedImages {
  @override
  List<PlacedImage> build(String sessionId) => [];

  void addImage({...}) {
    state = [...state, image];
  }
}
```

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

nativeSettingsProvider ←── localePreferenceProvider (iOS settings sync)
                       ←── sizeUnitPreferenceProvider (iOS settings sync)

isarProvider ←── sidebarImageLocalDataSourceProvider

pdfDataSourceProvider ←── pdfDocumentRepositoryProvider ←── sessionPdfDocumentProvider(id)
                                                        ←── pdfPageImageProvider

imageNormalizationServiceProvider ←── imageValidationServiceProvider
                                  ←── imageToPdfServiceProvider

sidebarImageRepositoryProvider ←── sidebarImagesProvider

viewerSessionsProvider ←── (manages lifecycle of all session family providers)

sessionPdfDocumentProvider(id) ←── (used by PdfViewer, PdfPageList)
sessionPlacedImagesProvider(id) ←── (used by PlacedImagesLayer, PdfDropTarget)
sessionEditorSelectionProvider(id) ←── (used by PlacedImageOverlay, PdfViewer)
sessionDocumentDirtyProvider(id) ←── (used by PdfViewerScreen for save prompts)
sessionFileSourceProvider(id) ←── (used by PdfViewerScreen for save behavior)
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

  result.fold(
    (failure) {
      if (failure is PasswordRequiredFailure) {
        state = PdfViewerState.passwordRequired(filePath: filePath);
      } else {
        state = PdfViewerState.error(
          message: failure.message,
          filePath: filePath,
        );
      }
    },
    (document) => PdfViewerState.loaded(document: document, scale: 1.0, ...),
  );
}
```

## Related Documentation

- [ARCHITECTURE.md](./ARCHITECTURE.md) — High-level architecture
- [PDF_EDITING.md](./PDF_EDITING.md) — Image placement and save system
- [adr/003-state-management-riverpod.md](./adr/003-state-management-riverpod.md) — ADR for Riverpod choice
