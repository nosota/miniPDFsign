import Cocoa
import FlutterMacOS
import desktop_multi_window

@main
class AppDelegate: FlutterAppDelegate {
  /// Global Settings window ID, shared across all Flutter engines.
  /// Used to enforce singleton pattern for Settings window.
  static var settingsWindowId: String?

  /// Global map of open PDF files: filePath -> windowId.
  /// Used to prevent opening the same file twice.
  static var openPdfFiles: [String: String] = [:]

  /// Channel for sending file paths to Flutter (main window).
  private var fileHandlerChannel: FlutterMethodChannel?

  /// Files received before Flutter engine is ready.
  private var pendingFiles: [String] = []

  /// Whether Flutter has signaled it's ready to receive files.
  private var isFlutterReady = false

  /// Sets up the file handler channel for Finder integration.
  /// Called asynchronously after app launch to ensure Flutter is ready.
  private func setupFileHandlerChannel() {
    guard let mainController = mainFlutterWindow?.contentViewController as? FlutterViewController else {
      // Retry after a short delay if Flutter window not ready yet
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
        self?.setupFileHandlerChannel()
      }
      return
    }

    setupSettingsSingletonChannel(binaryMessenger: mainController.engine.binaryMessenger)
    setupOpenPdfFilesChannel(binaryMessenger: mainController.engine.binaryMessenger)
    setupWindowListChannel(binaryMessenger: mainController.engine.binaryMessenger)

    // Setup file handler channel for Finder integration
    fileHandlerChannel = FlutterMethodChannel(
      name: "com.pdfsign/file_handler",
      binaryMessenger: mainController.engine.binaryMessenger
    )

    fileHandlerChannel?.setMethodCallHandler { [weak self] call, result in
      if call.method == "ready" {
        self?.isFlutterReady = true
        self?.sendPendingFiles()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    // Don't auto-terminate when last window closes
    // Flutter/Welcome window handles app lifecycle with exit(0)
    return false
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    // Delay channel setup to next run loop iteration
    // This ensures Flutter engine is fully initialized
    DispatchQueue.main.async { [weak self] in
      self?.setupFileHandlerChannel()
    }
    // Register plugin callback for new windows created by desktop_multi_window
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      RegisterGeneratedPlugins(registry: controller)

      // Setup channels for sub-windows
      setupSettingsSingletonChannel(binaryMessenger: controller.engine.binaryMessenger)
      setupOpenPdfFilesChannel(binaryMessenger: controller.engine.binaryMessenger)
      setupWindowListChannel(binaryMessenger: controller.engine.binaryMessenger)

      // Setup window lifecycle channel for sub-windows
      // This handles window close events and allows Flutter to control closing
      let windowChannel = FlutterMethodChannel(
        name: "com.pdfsign/window",
        binaryMessenger: controller.engine.binaryMessenger
      )

      // Setup method channel for toolbar requests
      let toolbarChannel = FlutterMethodChannel(
        name: "com.pdfsign/toolbar",
        binaryMessenger: controller.engine.binaryMessenger
      )

      toolbarChannel.setMethodCallHandler { [weak controller] call, result in
        NSLog("ToolbarChannel: received method call '%@'", call.method)
        guard let controller = controller else {
          NSLog("ToolbarChannel: controller is nil!")
          result(nil)
          return
        }

        switch call.method {
        case "setupToolbar":
          // Setup toolbar when Flutter explicitly requests it
          NSLog("ToolbarChannel: setupToolbar called")
          DispatchQueue.main.async {
            NSLog("ToolbarChannel: in main queue, checking window...")
            if let window = controller.view.window {
              NSLog("ToolbarChannel: window found, creating toolbar helper")
              let toolbarHelper = PDFSignToolbarHelper(
                window: window,
                binaryMessenger: controller.engine.binaryMessenger
              )
              toolbarHelper.setupToolbar()

              // Keep reference to prevent deallocation
              objc_setAssociatedObject(
                window,
                "toolbarHelper",
                toolbarHelper,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
              )
              NSLog("ToolbarChannel: toolbar setup complete")
            } else {
              NSLog("ToolbarChannel: window is NIL! Retrying in 100ms...")
              // Retry after a short delay
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let window = controller.view.window {
                  NSLog("ToolbarChannel: retry succeeded, window found")
                  let toolbarHelper = PDFSignToolbarHelper(
                    window: window,
                    binaryMessenger: controller.engine.binaryMessenger
                  )
                  toolbarHelper.setupToolbar()
                  objc_setAssociatedObject(
                    window,
                    "toolbarHelper",
                    toolbarHelper,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                  )
                  NSLog("ToolbarChannel: retry toolbar setup complete")
                } else {
                  NSLog("ToolbarChannel: retry failed, window still nil!")
                }
              }
            }
          }
          result(nil)

        default:
          result(FlutterMethodNotImplemented)
        }
      }

      // Setup window channel handler for close/destroy operations
      windowChannel.setMethodCallHandler { [weak controller] call, result in
        guard let controller = controller else {
          result(nil)
          return
        }

        DispatchQueue.main.async {
          switch call.method {
          case "close":
            // Close the window (triggers windowShouldClose delegate)
            controller.view.window?.performClose(nil)
            result(nil)

          case "destroy":
            // Force close without asking delegate
            controller.view.window?.close()
            result(nil)

          case "hide":
            // Hide the window
            controller.view.window?.orderOut(nil)
            result(nil)

          case "show":
            // Show and focus the window
            controller.view.window?.makeKeyAndOrderFront(nil)
            result(nil)

          case "setPreventClose":
            // Enable/disable close prevention (sets up delegate)
            let prevent = call.arguments as? Bool ?? false
            NSLog("WindowChannel: setPreventClose(%@) called", prevent ? "true" : "false")

            // Helper function to setup delegate
            func setupDelegate(window: NSWindow) {
              if prevent {
                let delegate = SubWindowDelegate(
                  window: window,
                  channel: windowChannel
                )
                window.delegate = delegate
                // Keep reference
                objc_setAssociatedObject(
                  window,
                  "windowDelegate",
                  delegate,
                  .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
                NSLog("WindowChannel: SubWindowDelegate set up successfully")

                // Send current focus state to Flutter immediately after delegate setup.
                // This ensures Flutter knows the correct state even if the initial
                // windowDidBecomeKey/windowDidResignKey event was missed (e.g., when
                // delegate setup was delayed by 100ms retry).
                if window.isKeyWindow {
                  NSLog("WindowChannel: Window is key, sending onWindowFocus")
                  windowChannel.invokeMethod("onWindowFocus", arguments: nil)
                } else {
                  NSLog("WindowChannel: Window is not key, sending onWindowBlur")
                  windowChannel.invokeMethod("onWindowBlur", arguments: nil)
                }
              } else {
                window.delegate = nil
                objc_setAssociatedObject(
                  window,
                  "windowDelegate",
                  nil,
                  .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
                NSLog("WindowChannel: SubWindowDelegate removed")
              }
            }

            if let window = controller.view.window {
              NSLog("WindowChannel: window found, setting up delegate")
              setupDelegate(window: window)
            } else {
              NSLog("WindowChannel: window is NIL! Retrying in 100ms...")
              // Retry after a short delay - window might not be ready yet
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let window = controller.view.window {
                  NSLog("WindowChannel: retry succeeded, window found")
                  setupDelegate(window: window)
                } else {
                  NSLog("WindowChannel: retry failed, window still nil!")
                }
              }
            }
            result(nil)

          default:
            result(FlutterMethodNotImplemented)
          }
        }
      }

      // Setup drop target for sub-windows (desktop_drop only handles main window)
      DispatchQueue.main.async {
        if let window = controller.view.window {
          let dropHelper = SubWindowDropTarget(
            flutterViewController: controller,
            binaryMessenger: controller.engine.binaryMessenger
          )
          dropHelper.setup()

          // Keep reference to prevent deallocation
          objc_setAssociatedObject(
            window,
            "dropHelper",
            dropHelper,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
          )
        }
      }
    }
  }

  /// Called by macOS when user opens files via Finder (Open With, double-click, drag to Dock).
  override func application(_ sender: NSApplication, openFiles filenames: [String]) {
    let pdfFiles = filenames
      .filter { $0.lowercased().hasSuffix(".pdf") }
      .filter { FileManager.default.fileExists(atPath: $0) }

    guard !pdfFiles.isEmpty else {
      sender.reply(toOpenOrPrint: .failure)
      return
    }

    if isFlutterReady {
      for file in pdfFiles {
        fileHandlerChannel?.invokeMethod("openFile", arguments: file)
      }
    } else {
      // Flutter not ready yet, queue files for later
      pendingFiles.append(contentsOf: pdfFiles)
    }

    sender.reply(toOpenOrPrint: .success)
  }

  /// Alternative method for opening URLs (macOS 10.13+).
  /// Some versions of macOS may call this instead of openFiles.
  override func application(_ application: NSApplication, open urls: [URL]) {
    let pdfPaths = urls
      .filter { $0.pathExtension.lowercased() == "pdf" }
      .map { $0.path }
      .filter { FileManager.default.fileExists(atPath: $0) }

    guard !pdfPaths.isEmpty else { return }

    if isFlutterReady {
      for path in pdfPaths {
        fileHandlerChannel?.invokeMethod("openFile", arguments: path)
      }
    } else {
      // Only add files not already in queue (prevents duplicates)
      let newPaths = pdfPaths.filter { !pendingFiles.contains($0) }
      if !newPaths.isEmpty {
        pendingFiles.append(contentsOf: newPaths)
      }
    }
  }

  /// Sends queued files to Flutter once it's ready.
  private func sendPendingFiles() {
    guard isFlutterReady,
          !pendingFiles.isEmpty,
          let channel = fileHandlerChannel else { return }

    for file in pendingFiles {
      channel.invokeMethod("openFile", arguments: file)
    }
    pendingFiles.removeAll()
  }
}

/// Sets up the Settings singleton channel for a Flutter engine.
/// This channel allows any Flutter engine to check/set the global Settings window ID.
func setupSettingsSingletonChannel(binaryMessenger: FlutterBinaryMessenger) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/settings_singleton",
    binaryMessenger: binaryMessenger
  )

  channel.setMethodCallHandler { call, result in
    switch call.method {
    case "getSettingsWindowId":
      // Return the current Settings window ID (or nil if none)
      result(AppDelegate.settingsWindowId)

    case "setSettingsWindowId":
      // Store the Settings window ID
      let windowId = call.arguments as? String
      AppDelegate.settingsWindowId = windowId
      result(nil)

    case "clearSettingsWindowId":
      // Clear the Settings window ID
      AppDelegate.settingsWindowId = nil
      result(nil)

    case "focusSettingsWindow":
      // Try to bring the Settings window to front
      guard AppDelegate.settingsWindowId != nil else {
        result(false)
        return
      }

      // Find the window with title "Settings" and bring it to front
      for window in NSApplication.shared.windows {
        if window.contentViewController is FlutterViewController {
          if window.title == "Settings" {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            result(true)
            return
          }
        }
      }
      // If we have an ID but couldn't find the window, it was closed
      AppDelegate.settingsWindowId = nil
      result(false)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

/// Sets up the open PDF files channel for a Flutter engine.
/// This channel tracks which PDF files are currently open to prevent duplicates.
func setupOpenPdfFilesChannel(binaryMessenger: FlutterBinaryMessenger) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/open_pdf_files",
    binaryMessenger: binaryMessenger
  )

  channel.setMethodCallHandler { call, result in
    switch call.method {
    case "getWindowIdForFile":
      // Return the window ID for a file path (or nil if not open)
      guard let filePath = call.arguments as? String else {
        result(nil)
        return
      }
      result(AppDelegate.openPdfFiles[filePath])

    case "registerPdfFile":
      // Register a file as open with its window ID
      guard let args = call.arguments as? [String: String],
            let filePath = args["filePath"],
            let windowId = args["windowId"] else {
        result(nil)
        return
      }
      AppDelegate.openPdfFiles[filePath] = windowId
      NSLog("OpenPdfFilesChannel: registered %@ -> %@", filePath, windowId)
      result(nil)

    case "unregisterPdfFile":
      // Unregister a file when its window closes
      guard let filePath = call.arguments as? String else {
        result(nil)
        return
      }
      AppDelegate.openPdfFiles.removeValue(forKey: filePath)
      NSLog("OpenPdfFilesChannel: unregistered %@", filePath)
      result(nil)

    case "focusPdfWindow":
      // Try to bring the window for a file to front
      guard let filePath = call.arguments as? String,
            AppDelegate.openPdfFiles[filePath] != nil else {
        result(false)
        return
      }

      // Find the window by checking all Flutter windows
      for window in NSApplication.shared.windows {
        if window.contentViewController is FlutterViewController {
          // Check if this window's title contains the file name
          let fileName = (filePath as NSString).lastPathComponent
          if window.title.contains(fileName) {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            NSLog("OpenPdfFilesChannel: focused window for %@", filePath)
            result(true)
            return
          }
        }
      }

      // Window not found, might be closed - clean up the entry
      AppDelegate.openPdfFiles.removeValue(forKey: filePath)
      NSLog("OpenPdfFilesChannel: window for %@ not found, cleaned up", filePath)
      result(false)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

/// Sets up the window list channel for a Flutter engine.
/// This channel provides the list of all visible windows for the Window menu.
func setupWindowListChannel(binaryMessenger: FlutterBinaryMessenger) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/window_list",
    binaryMessenger: binaryMessenger
  )

  channel.setMethodCallHandler { call, result in
    switch call.method {
    case "getWindowList":
      // Return list of all visible Flutter windows with metadata
      var windowList: [[String: Any]] = []

      for window in NSApplication.shared.windows {
        // Only include Flutter windows (have FlutterViewController)
        guard window.contentViewController is FlutterViewController else {
          continue
        }

        // Skip hidden windows
        guard window.isVisible else {
          continue
        }

        // Determine window type based on title and window number
        // Main window (Welcome) has window number matching main window
        let isMainWindow = window == NSApp.windows.first { $0.contentViewController is FlutterViewController && $0.isMainWindow }
        let title = window.title

        var windowType = "pdf"
        if isMainWindow || title == "PDFSign" {
          windowType = "welcome"
        } else if title == "Settings" || title == "Настройки" {
          windowType = "settings"
        }

        // Get window ID - use window number as string ID
        // For desktop_multi_window, the window number corresponds to the ID
        let windowId = String(window.windowNumber)

        // For Welcome window, use "0" as the conventional ID
        let finalWindowId = windowType == "welcome" ? "0" : windowId

        let windowInfo: [String: Any] = [
          "windowId": finalWindowId,
          "title": title,
          "type": windowType,
          "isKey": window.isKeyWindow,
          "filePath": NSNull()  // Not tracking file paths in native side
        ]

        windowList.append(windowInfo)
      }

      // Sort: PDFs first (by window number/open order), then Settings, then Welcome
      windowList.sort { (a, b) -> Bool in
        let typeA = a["type"] as? String ?? "pdf"
        let typeB = b["type"] as? String ?? "pdf"

        // Define sort order: pdf=0, settings=1, welcome=2
        let orderA = typeA == "pdf" ? 0 : (typeA == "settings" ? 1 : 2)
        let orderB = typeB == "pdf" ? 0 : (typeB == "settings" ? 1 : 2)

        if orderA != orderB {
          return orderA < orderB
        }

        // Within same type, sort by window ID (open order)
        let idA = a["windowId"] as? String ?? ""
        let idB = b["windowId"] as? String ?? ""
        return idA < idB
      }

      result(windowList)

    case "focusWindow":
      // Bring window to front by ID
      guard let windowId = call.arguments as? String else {
        result(false)
        return
      }

      // Special case for Welcome window (ID "0")
      if windowId == "0" {
        for window in NSApplication.shared.windows {
          if window.contentViewController is FlutterViewController {
            if window.title == "PDFSign" || window == NSApp.mainWindow {
              window.makeKeyAndOrderFront(nil)
              NSApp.activate(ignoringOtherApps: true)
              result(true)
              return
            }
          }
        }
      }

      // Find window by window number
      if let windowNumber = Int(windowId) {
        for window in NSApplication.shared.windows {
          if window.windowNumber == windowNumber {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            result(true)
            return
          }
        }
      }

      result(false)

    case "minimizeWindow":
      // Minimize the key window
      NSApp.keyWindow?.miniaturize(nil)
      result(nil)

    case "zoomWindow":
      // Zoom (maximize/restore) the key window
      NSApp.keyWindow?.zoom(nil)
      result(nil)

    case "bringAllToFront":
      // Bring all app windows to front
      NSApp.activate(ignoringOtherApps: true)
      for window in NSApplication.shared.windows {
        if window.contentViewController is FlutterViewController && window.isVisible {
          window.orderFront(nil)
        }
      }
      result(nil)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

/// Delegate for sub-windows to intercept close events and track focus.
/// Sends events to Flutter: onWindowClose, onWindowFocus, onWindowBlur.
/// Flutter decides whether to close and calls 'destroy' when ready.
class SubWindowDelegate: NSObject, NSWindowDelegate {
  private weak var window: NSWindow?
  private let channel: FlutterMethodChannel
  private var preventClose: Bool = true

  init(window: NSWindow, channel: FlutterMethodChannel) {
    self.window = window
    self.channel = channel
    super.init()
  }

  func setPreventClose(_ prevent: Bool) {
    preventClose = prevent
  }

  func windowShouldClose(_ sender: NSWindow) -> Bool {
    NSLog("SubWindowDelegate: windowShouldClose called, preventClose=%@", preventClose ? "true" : "false")
    if preventClose {
      // Notify Flutter about close request
      NSLog("SubWindowDelegate: invoking onWindowClose to Flutter")
      channel.invokeMethod("onWindowClose", arguments: nil)
      // Prevent immediate close - Flutter will call 'destroy' when ready
      return false
    }
    return true
  }

  func windowWillClose(_ notification: Notification) {
    // Window is closing, clean up delegate reference
    window?.delegate = nil
  }

  func windowDidBecomeKey(_ notification: Notification) {
    // Window gained focus
    channel.invokeMethod("onWindowFocus", arguments: nil)
  }

  func windowDidResignKey(_ notification: Notification) {
    // Window lost focus
    channel.invokeMethod("onWindowBlur", arguments: nil)
  }
}

/// Helper class to manage NSToolbar for PDF viewer windows.
class PDFSignToolbarHelper: NSObject, NSToolbarDelegate, NSToolbarItemValidation {
  private weak var window: NSWindow?
  private var methodChannel: FlutterMethodChannel?
  private let shareItemIdentifier = NSToolbarItem.Identifier("ShareItem")

  init(window: NSWindow, binaryMessenger: FlutterBinaryMessenger) {
    self.window = window
    self.methodChannel = FlutterMethodChannel(
      name: "com.pdfsign/toolbar",
      binaryMessenger: binaryMessenger
    )
    super.init()
  }

  func setupToolbar() {
    guard let window = window else {
      NSLog("PDFSignToolbarHelper: window is nil")
      return
    }

    NSLog("PDFSignToolbarHelper: setting up toolbar for window %@", window.title)
    let toolbar = NSToolbar(identifier: "PDFSignToolbar")
    toolbar.delegate = self
    toolbar.displayMode = .iconOnly
    toolbar.allowsUserCustomization = false
    window.toolbar = toolbar
    NSLog("PDFSignToolbarHelper: toolbar set up successfully")
  }

  // MARK: - NSToolbarDelegate

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [shareItemIdentifier, .flexibleSpace]
  }

  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [.flexibleSpace, shareItemIdentifier]
  }

  func toolbar(
    _ toolbar: NSToolbar,
    itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
    willBeInsertedIntoToolbar flag: Bool
  ) -> NSToolbarItem? {
    NSLog("PDFSignToolbarHelper: toolbar item requested: %@", itemIdentifier.rawValue)
    if itemIdentifier == shareItemIdentifier {
      let item = NSToolbarItem(itemIdentifier: itemIdentifier)
      item.label = "Share"
      item.paletteLabel = "Share"
      item.toolTip = "Share this document"

      // Use SF Symbol on macOS 11+, fallback to named image on older versions
      if #available(macOS 11.0, *) {
        if let image = NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: "Share") {
          item.image = image
        }
      } else {
        // Fallback for macOS 10.15
        item.image = NSImage(named: NSImage.actionTemplateName)
      }

      item.action = #selector(shareButtonClicked)
      item.target = self
      item.isEnabled = true
      item.autovalidates = false  // Disable auto-validation
      NSLog("PDFSignToolbarHelper: Share item created, isEnabled=%d", item.isEnabled ? 1 : 0)
      return item
    }
    return nil
  }

  @objc func shareButtonClicked() {
    methodChannel?.invokeMethod("onSharePressed", arguments: nil)
  }

  // MARK: - NSToolbarItemValidation

  /// Always enable the Share toolbar item.
  @objc func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
    NSLog("PDFSignToolbarHelper: validateToolbarItem called for %@, returning true", item.itemIdentifier.rawValue)
    return true
  }
}

/// Helper class to setup drop target for sub-windows.
/// desktop_drop only handles the main window, so we need custom handling for sub-windows.
class SubWindowDropTarget: NSObject {
  private weak var flutterViewController: FlutterViewController?
  private var channel: FlutterMethodChannel?
  private var dropView: DropTargetView?

  init(flutterViewController: FlutterViewController, binaryMessenger: FlutterBinaryMessenger) {
    self.flutterViewController = flutterViewController
    self.channel = FlutterMethodChannel(
      name: "desktop_drop",
      binaryMessenger: binaryMessenger
    )
    super.init()
  }

  func setup() {
    guard let vc = flutterViewController, let channel = channel else { return }

    let dropView = DropTargetView(frame: vc.view.bounds, channel: channel)
    dropView.autoresizingMask = [.width, .height]

    dropView.registerForDraggedTypes(
      NSFilePromiseReceiver.readableDraggedTypes.map { NSPasteboard.PasteboardType($0) }
    )
    dropView.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])

    vc.view.addSubview(dropView)
    self.dropView = dropView
  }
}

/// NSView that handles drag-and-drop operations and sends events to Flutter.
class DropTargetView: NSView {
  private let channel: FlutterMethodChannel

  init(frame frameRect: NSRect, channel: FlutterMethodChannel) {
    self.channel = channel
    super.init(frame: frameRect)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
    channel.invokeMethod("entered", arguments: convertPoint(sender.draggingLocation))
    return .copy
  }

  override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
    channel.invokeMethod("updated", arguments: convertPoint(sender.draggingLocation))
    return .copy
  }

  override func draggingExited(_ sender: NSDraggingInfo?) {
    channel.invokeMethod("exited", arguments: nil)
  }

  /// Directory URL used for accepting file promises.
  private lazy var destinationURL: URL = {
    let destinationURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("Drops")
    try? FileManager.default.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
    return destinationURL
  }()

  /// Queue used for reading and writing file promises.
  private lazy var workQueue: OperationQueue = {
    let providerQueue = OperationQueue()
    providerQueue.qualityOfService = .userInitiated
    return providerQueue
  }()

  override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
    var urls = [String]()

    let searchOptions: [NSPasteboard.ReadingOptionKey: Any] = [
      .urlReadingFileURLsOnly: true,
    ]

    let group = DispatchGroup()

    sender.enumerateDraggingItems(
      options: [],
      for: nil,
      classes: [NSFilePromiseReceiver.self, NSURL.self],
      searchOptions: searchOptions
    ) { draggingItem, _, _ in
      switch draggingItem.item {
      case let filePromiseReceiver as NSFilePromiseReceiver:
        group.enter()
        filePromiseReceiver.receivePromisedFiles(
          atDestination: self.destinationURL,
          options: [:],
          operationQueue: self.workQueue
        ) { fileURL, error in
          if error == nil {
            urls.append(fileURL.path)
          }
          group.leave()
        }
      case let fileURL as URL:
        urls.append(fileURL.path)
      default:
        break
      }
    }

    group.notify(queue: .main) {
      self.channel.invokeMethod("performOperation", arguments: urls)
    }
    return true
  }

  private func convertPoint(_ location: NSPoint) -> [CGFloat] {
    return [location.x, bounds.height - location.y]
  }
}
