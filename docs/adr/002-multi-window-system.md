# ADR-002: Multi-Window System

**Status:** Accepted
**Date:** 2024

## Context

PDFSign is a macOS document editor. Users expect to:
- Open multiple PDF files simultaneously
- Have each document in its own window
- Standard macOS window management (Cmd+W, Window menu, etc.)

Flutter by default is single-window. We need multi-window support.

## Decision

Use **desktop_multi_window** package with custom window management:

### Architecture

1. **Main Window** (Welcome) - Entry point, recent files
2. **Sub Windows** (PDF Viewer, Settings) - Created dynamically

### Key Components

| Component | Purpose |
|-----------|---------|
| `desktop_multi_window` | Create/manage native windows |
| `WindowManagerService` | Dart-side window tracking |
| `WindowArguments` | Pass data to new windows |
| `WindowBroadcast` | Inter-window communication |
| Platform Channels | Native macOS integration |

### Window Identification

- Welcome window: ID `"0"` (main window)
- Sub windows: Dynamic IDs from `desktop_multi_window`
- Use `window.windowNumber` for native lookups

### Duplicate Prevention

- Native-side registry: `openPdfFiles: [String: String]`
- Check before creating window
- Focus existing if file already open

## Consequences

### Positive

- **Native feel**: True macOS multi-window behavior
- **Independence**: Each window has its own Flutter engine
- **Isolation**: Crash in one window doesn't affect others
- **Standard UX**: Window menu, Cmd+`, minimize, etc.

### Negative

- **Memory**: Each window is a separate Flutter engine
- **Complexity**: Inter-window communication via broadcasts
- **State sync**: Providers are per-engine, need manual sync
- **Platform-specific**: This approach is macOS-specific

### Trade-offs

| Aspect | Multi-Engine | Single-Engine Approach |
|--------|--------------|------------------------|
| Memory | Higher | Lower |
| Isolation | Full | Shared state |
| Complexity | Higher | Lower |
| Native feel | Better | Requires workarounds |

## Alternatives Considered

1. **Tabs instead of windows** - Not standard for document editors
2. **Single window with document switcher** - Doesn't match macOS UX
3. **flutter_multi_window** - Less mature than desktop_multi_window

## Implementation Notes

### Window Creation Flow

```
1. User opens file
2. Check if already open (OpenPdfFilesChannel)
3. If open → focus existing window
4. If not → create via WindowController.create()
5. Register in openPdfFiles
6. New Flutter engine starts with WindowArguments
```

### Inter-Window Communication

```
WindowBroadcast.broadcastX() →
  WindowController.getAll() →
  For each window: window.invokeMethod()
```

## References

- [desktop_multi_window](https://pub.dev/packages/desktop_multi_window)
- [Apple HIG: Windows](https://developer.apple.com/design/human-interface-guidelines/windows)
