# ADR-003: State Management with Riverpod

**Status:** Accepted
**Date:** 2024

## Context

We need a state management solution that:
- Works well with Clean Architecture
- Supports dependency injection
- Handles async operations gracefully
- Is testable and maintainable

## Decision

Use **Riverpod** (flutter_riverpod) for all state management.

### Provider Types Used

| Provider Type | Use Case | Example |
|--------------|----------|---------|
| `StateProvider` | Simple UI state | `permissionRetryProvider` |
| `StateNotifierProvider` | Complex mutable state | `placedImagesProvider` |
| `AsyncNotifierProvider` | Async data with mutations | `recentFilesProvider` |
| `StreamNotifierProvider` | Reactive streams | `sidebarImagesProvider` |
| `Provider` | Computed values, DI | `pdfDocumentRepositoryProvider` |

### Code Generation

Use `riverpod_annotation` with `riverpod_generator`:

```dart
@Riverpod(keepAlive: true)
class PlacedImages extends _$PlacedImages {
  @override
  List<PlacedImage> build() => [];

  void addImage(PlacedImage image) {
    state = [...state, image];
  }
}
```

### Naming Conventions

- Providers: `camelCaseProvider` (e.g., `pdfDocumentProvider`)
- State classes: `PascalCase` (e.g., `PdfViewerState`)
- Notifier classes: `PascalCase` (e.g., `PlacedImagesNotifier`)

### Provider Lifecycle

Use `keepAlive: true` for providers that should persist:
- Document state (`pdfDocumentProvider`)
- Placed images (`placedImagesProvider`)
- Dirty state tracking (`documentDirtyProvider`)
- Repository instances

Default lifecycle (auto-dispose) for:
- Computed values
- Temporary UI state
- One-time async operations

## Consequences

### Positive

- **Compile-safe**: Provider dependencies checked at compile time
- **Testable**: Easy to override providers in tests
- **No context needed**: Access providers without BuildContext
- **Auto-dispose**: Providers dispose when not used
- **DevTools**: Built-in debugging support

### Negative

- **Learning curve**: Different from Provider/Bloc
- **Code generation**: Requires build_runner
- **Verbosity**: More boilerplate than simple setState

## Usage Patterns

### Reading State

```dart
// In widgets - reactive
final state = ref.watch(someProvider);

// In callbacks - one-time read
ref.read(someProvider.notifier).doSomething();
```

### Side Effects

```dart
// In widget build method
ref.listen(someProvider, (prev, next) {
  // Show snackbar, navigate, etc.
});
```

### Dependency Injection

```dart
@riverpod
PdfDocumentRepository pdfDocumentRepository(ref) {
  final dataSource = ref.watch(pdfDataSourceProvider);
  return PdfDocumentRepositoryImpl(dataSource);
}
```

## Alternatives Considered

1. **Provider** - Simpler but less powerful
2. **Bloc** - More boilerplate, event-driven
3. **GetX** - Less testable, magic strings
4. **MobX** - Reactive but less Flutter-native

## Testing

```dart
test('should add image', () {
  final container = ProviderContainer(
    overrides: [
      // Override dependencies if needed
    ],
  );

  container.read(placedImagesProvider.notifier).addImage(image);

  expect(container.read(placedImagesProvider), contains(image));
});
```

## References

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod 2.0 Migration](https://riverpod.dev/docs/migration/from_state_notifier)
