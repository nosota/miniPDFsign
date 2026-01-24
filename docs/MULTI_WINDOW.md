# Multi-Window System

PDFSign implements a multi-window architecture for macOS, allowing users to open multiple PDF documents simultaneously.

## Window Types

| Window | Class | Purpose | Count |
|--------|-------|---------|-------|
| Welcome | `WelcomeApp` | Recent files, file picker | 1 (main) |
| PDF Viewer | `PdfViewerApp` | Display/edit single PDF | Multiple |
| Settings | `SettingsApp` | App preferences | 0-1 (singleton) |

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Native macOS Layer                        │
│  AppDelegate.swift: Window creation, lifecycle, channels    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              desktop_multi_window Package                    │
│  WindowController: Create/manage sub-windows                │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                 WindowManagerService                         │
│  Dart singleton: Track windows, prevent duplicates          │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    App Widgets                               │
│  WelcomeApp / PdfViewerApp / SettingsApp                    │
└─────────────────────────────────────────────────────────────┘
```

## Entry Point (`main.dart`)

```dart
void main(List<String> args) async {
  // Parse window arguments
  final arguments = WindowArguments.fromArgs(args);

  // Route to appropriate app widget based on window type
  runApp(
    ProviderScope(
      child: switch (arguments.type) {
        WindowType.welcome => const WelcomeApp(),
        WindowType.pdfViewer => PdfViewerApp(filePath: arguments.filePath!),
        WindowType.settings => const SettingsApp(),
      },
    ),
  );
}
```

## WindowManagerService

Central service for window management (`lib/core/window/window_manager_service.dart`):

```dart
class WindowManagerService {
  static final instance = WindowManagerService._();

  // Track open PDF windows
  final Set<String> _openWindows = {};

  // Create new PDF viewer window
  Future<String?> createPdfWindow(String filePath);

  // Create or focus Settings window (singleton)
  Future<String?> createSettingsWindow();

  // Check if file is already open
  Future<String?> getWindowIdForFile(String filePath);
}
```

## Window Arguments

Arguments passed to sub-windows (`lib/core/window/window_arguments.dart`):

```dart
class WindowArguments {
  final WindowType type;
  final String? filePath;
  final String? fileName;

  // Serialize for window creation
  String toJson();

  // Parse from main() args
  factory WindowArguments.fromArgs(List<String> args);
}
```

## Inter-Window Communication

### WindowBroadcast

Broadcast messages to all windows (`lib/core/window/window_broadcast.dart`):

| Method | Purpose | Includes Self |
|--------|---------|---------------|
| `broadcastLocaleChanged()` | Sync locale preference | No |
| `broadcastHideWelcome()` | Hide welcome on PDF open | Yes |
| `broadcastDirtyStateChanged()` | Sync dirty state | No |
| `broadcastCloseAll()` | Close all PDF windows | No |
| `broadcastSaveAll()` | Save all dirty documents | No |

### Platform Channels

Native communication (`AppDelegate.swift`):

| Channel | Purpose |
|---------|---------|
| `com.pdfsign/window` | Window lifecycle (close, show, hide) |
| `com.pdfsign/toolbar` | Toolbar button callbacks |
| `com.pdfsign/settings_singleton` | Settings window singleton enforcement |
| `com.pdfsign/open_pdf_files` | Track open files, prevent duplicates |
| `com.pdfsign/window_list` | Window menu support |

## Duplicate File Prevention

When opening a PDF that's already open:

```
1. User tries to open "Report.pdf"
   │
2. WindowManagerService checks openPdfFiles registry
   │
3. If already open:
   │   └─► Focus existing window (OpenPdfFilesChannel.focusPdfWindow)
   │
4. If not open:
       └─► Create new window, register in openPdfFiles
```

## Settings Window Singleton

Only one Settings window can exist:

```
1. User requests Settings (Cmd+,)
   │
2. SettingsSingletonChannel.getSettingsWindowId()
   │
3. If window exists:
   │   └─► Focus existing window
   │
4. If not:
       └─► Create new Settings window
       └─► Register window ID
```

## Welcome Window Behavior

| Event | Welcome Window Action |
|-------|----------------------|
| App launch | Show |
| PDF opened | Hide (broadcast) |
| Last PDF closed | Show |
| Cmd+W on Welcome (with other windows) | Hide |
| Cmd+W on Welcome (only window) | Quit app |

## Window Lifecycle

### PDF Window Close

```
1. User clicks close (×) or Cmd+W
   │
2. SubWindowDelegate.windowShouldClose() intercepts
   │
3. Flutter receives onWindowClose event
   │
4. If dirty:
   │   └─► Show SaveChangesDialog
   │       ├─► Save → save, then close
   │       ├─► Don't Save → close
   │       └─► Cancel → abort close
   │
5. Call SubWindowChannel.destroy() to close
   │
6. Unregister from openPdfFiles
```

## Focus Tracking

Each window tracks its focus state:

```dart
class _PdfViewerAppState extends ConsumerState<PdfViewerApp> {
  bool _isWindowFocused = true;

  @override
  void onWindowFocus() {
    _isWindowFocused = true;
    setState(() {});
  }

  @override
  void onWindowBlur() {
    _isWindowFocused = false;
    setState(() {});
  }
}
```

This is used for:
- Rendering `PlatformMenuBar` only in focused window
- Updating Window menu checkmarks
- Preventing menu conflicts between windows

## Native Window Setup

In `AppDelegate.swift`, each sub-window gets:

1. Plugin registration
2. Platform channel setup
3. Window delegate for lifecycle events
4. Drop target for drag-and-drop
5. Toolbar (PDF windows only)
