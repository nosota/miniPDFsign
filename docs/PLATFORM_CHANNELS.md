# Platform Channels

PDFSign uses Flutter platform channels to integrate with native macOS functionality.

## Channel Overview

| Channel Name | Dart Class | Purpose |
|--------------|------------|---------|
| `com.pdfsign/toolbar` | `ToolbarChannel` | Toolbar button callbacks |
| `com.pdfsign/window` | `SubWindowChannel` | Window lifecycle management |
| `com.pdfsign/file_handler` | `FileOpenHandler` | Finder file open integration |
| `com.pdfsign/settings_singleton` | `SettingsSingletonChannel` | Settings window singleton |
| `com.pdfsign/open_pdf_files` | `OpenPdfFilesChannel` | Track open PDF files |
| `com.pdfsign/window_list` | `WindowListChannel` | Window menu support |

## Toolbar Channel

**File:** `lib/core/platform/toolbar_channel.dart`

Handles native toolbar in PDF viewer windows.

### Flutter → Native

| Method | Arguments | Description |
|--------|-----------|-------------|
| `setupToolbar` | none | Request toolbar setup for current window |

### Native → Flutter

| Method | Arguments | Description |
|--------|-----------|-------------|
| `onSharePressed` | none | Share button was clicked |

### Usage

```dart
// In PdfViewerApp.initState()
ToolbarChannel.init();
ToolbarChannel.setOnSharePressed(_handleShare);
ToolbarChannel.setupToolbar();

// Cleanup in dispose()
ToolbarChannel.setOnSharePressed(null);
```

## Window Channel

**File:** `lib/core/platform/sub_window_channel.dart`

Manages sub-window lifecycle.

### Flutter → Native

| Method | Arguments | Description |
|--------|-----------|-------------|
| `close` | none | Request window close (triggers delegate) |
| `destroy` | none | Force close without delegate |
| `hide` | none | Hide window |
| `show` | none | Show and focus window |
| `setPreventClose` | `bool` | Enable/disable close interception |

### Native → Flutter

| Method | Arguments | Description |
|--------|-----------|-------------|
| `onWindowClose` | none | User attempted to close window |
| `onWindowFocus` | none | Window gained focus |
| `onWindowBlur` | none | Window lost focus |

### Usage

```dart
// Prevent immediate close, handle in Flutter
SubWindowChannel.setPreventClose(true);
SubWindowChannel.setOnWindowClose(() async {
  if (isDirty) {
    final result = await showSaveDialog();
    if (result == SaveResult.cancel) return;
  }
  SubWindowChannel.destroy(); // Actually close
});
```

## File Handler Channel

**File:** `lib/core/platform/file_open_handler.dart`

Handles files opened via Finder (double-click, "Open With").

### Flutter → Native

| Method | Arguments | Description |
|--------|-----------|-------------|
| `ready` | none | Signal Flutter is ready to receive files |

### Native → Flutter

| Method | Arguments | Description |
|--------|-----------|-------------|
| `openFile` | `String` path | Open file from Finder |

### Flow

```
1. User double-clicks PDF in Finder
   │
2. macOS calls AppDelegate.application(_:openFiles:)
   │
3. If Flutter ready:
   │   └─► fileHandlerChannel.invokeMethod("openFile", path)
   │
4. If Flutter not ready:
       └─► Queue file, send when ready
```

## Settings Singleton Channel

**File:** `lib/core/platform/settings_singleton_channel.dart`

Enforces single Settings window across all Flutter engines.

### Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `getSettingsWindowId` | none | `String?` | Get current Settings window ID |
| `setSettingsWindowId` | `String` | void | Register Settings window |
| `clearSettingsWindowId` | none | void | Unregister Settings window |
| `focusSettingsWindow` | none | `bool` | Focus existing Settings window |

### Usage

```dart
Future<void> openSettings() async {
  // Check if Settings already open
  final existingId = await SettingsSingletonChannel.getSettingsWindowId();
  if (existingId != null) {
    // Focus existing window
    await SettingsSingletonChannel.focusSettingsWindow();
    return;
  }

  // Create new Settings window
  final windowId = await WindowController.create(...);
  await SettingsSingletonChannel.setSettingsWindowId(windowId);
}
```

## Open PDF Files Channel

**File:** `lib/core/platform/open_pdf_files_channel.dart`

Tracks which PDFs are currently open to prevent duplicates.

### Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `getWindowIdForFile` | `String` path | `String?` | Get window ID for file |
| `registerPdfFile` | path, windowId | void | Register file as open |
| `unregisterPdfFile` | `String` path | void | Unregister closed file |
| `focusPdfWindow` | `String` path | `bool` | Focus window for file |

### Native Storage

The native side maintains a dictionary:
```swift
static var openPdfFiles: [String: String] = [:] // filePath -> windowId
```

## Window List Channel

**File:** `lib/core/platform/window_list_channel.dart`

Provides window list for Window menu.

### Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `getWindowList` | none | `List<WindowInfo>` | Get all visible windows |
| `focusWindow` | `String` windowId | `bool` | Focus window by ID |
| `minimizeWindow` | none | void | Minimize current window |
| `zoomWindow` | none | void | Zoom current window |
| `bringAllToFront` | none | void | Bring all windows to front |

### WindowInfo Structure

```dart
class WindowInfo {
  final String windowId;
  final String title;
  final String type;  // "welcome", "pdf", "settings"
  final bool isKey;   // Is currently focused
}
```

## Native Implementation

All channels are set up in `AppDelegate.swift`:

### Main Window (Welcome)

```swift
func setupFileHandlerChannel() {
  fileHandlerChannel = FlutterMethodChannel(
    name: "com.pdfsign/file_handler",
    binaryMessenger: mainController.engine.binaryMessenger
  )
  // ... handler setup
}
```

### Sub Windows (PDF, Settings)

```swift
FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
  // Setup all channels for this window's engine
  setupSettingsSingletonChannel(binaryMessenger: controller.engine.binaryMessenger)
  setupOpenPdfFilesChannel(binaryMessenger: controller.engine.binaryMessenger)
  setupWindowListChannel(binaryMessenger: controller.engine.binaryMessenger)

  let toolbarChannel = FlutterMethodChannel(
    name: "com.pdfsign/toolbar",
    binaryMessenger: controller.engine.binaryMessenger
  )
  // ... handler setup

  let windowChannel = FlutterMethodChannel(
    name: "com.pdfsign/window",
    binaryMessenger: controller.engine.binaryMessenger
  )
  // ... handler setup
}
```

## Error Handling

All channel methods should handle errors gracefully:

```dart
static Future<void> someMethod() async {
  try {
    await _channel.invokeMethod('someMethod');
  } catch (e) {
    if (kDebugMode) {
      print('Channel error: $e');
    }
    // Graceful fallback
  }
}
```

## Debugging

Enable logging on both sides:

**Dart:**
```dart
if (kDebugMode) {
  print('ToolbarChannel: calling setupToolbar...');
}
```

**Swift:**
```swift
NSLog("ToolbarChannel: setupToolbar called")
```

View logs:
- Flutter: Terminal output
- Native: Console.app or Xcode console
