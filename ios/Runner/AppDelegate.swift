import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  // Event channel for incoming file URLs
  private var openInFileEventSink: FlutterEventSink?
  // Store pending file URL for cold start (when app opens with a file)
  private var pendingOpenInFileUrl: URL?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController

    // Register settings channel for native UserDefaults access
    let settingsChannel = FlutterMethodChannel(
      name: "com.ivanvaganov.minipdfsign/settings",
      binaryMessenger: controller.binaryMessenger
    )
    settingsChannel.setMethodCallHandler { [weak self] call, result in
      self?.handleSettingsMethodCall(call: call, result: result)
    }

    // Register file bookmark handler for security-scoped bookmarks
    let bookmarkChannel = FlutterMethodChannel(
      name: "com.ivanvaganov.minipdfsign/file_bookmarks",
      binaryMessenger: controller.binaryMessenger
    )
    bookmarkChannel.setMethodCallHandler { [weak self] call, result in
      self?.handleMethodCall(call: call, result: result)
    }

    // Register EventChannel for "Open In" file URLs
    let openInEventChannel = FlutterEventChannel(
      name: "com.ivanvaganov.minipdfsign/open_in_files",
      binaryMessenger: controller.binaryMessenger
    )
    openInEventChannel.setStreamHandler(self)

    // Check if app was launched with a file URL (cold start)
    if let url = launchOptions?[.url] as? URL, url.isFileURL {
      pendingOpenInFileUrl = url
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - Handle file opening via "Open In" / Share

  /// Handle URL when app is already running (warm start).
  /// Note: receive_sharing_intent doesn't support direct file:// URLs,
  /// so we handle them ourselves and send to Flutter via EventChannel.
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    // Handle file:// URLs ourselves
    if url.isFileURL {
      // Copy file to app's cache directory for reliable access
      if let localPath = copyFileToCache(url: url) {
        sendFileToFlutter(path: localPath, originalName: url.lastPathComponent)
      } else {
        // Try sending original path anyway (might work for files from same app)
        sendFileToFlutter(path: url.path, originalName: url.lastPathComponent)
      }
      return true
    }

    // For non-file URLs (like ShareMedia-... from Share Extension), let plugins handle it
    return super.application(app, open: url, options: options)
  }

  /// Copy file to app's cache directory for reliable access
  private func copyFileToCache(url: URL) -> String? {
    let fileManager = FileManager.default
    let cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    let openInDir = cacheDir.appendingPathComponent("OpenIn", isDirectory: true)

    // Create directory if needed
    try? fileManager.createDirectory(at: openInDir, withIntermediateDirectories: true)

    // Clean old files (older than 1 hour)
    cleanOldFiles(in: openInDir)

    // Generate unique filename
    let timestamp = Int(Date().timeIntervalSince1970 * 1000)
    let originalName = url.lastPathComponent
    let destURL = openInDir.appendingPathComponent("\(timestamp)_\(originalName)")

    // Start security-scoped access
    let accessing = url.startAccessingSecurityScopedResource()
    defer {
      if accessing {
        url.stopAccessingSecurityScopedResource()
      }
    }

    do {
      // Remove existing file if any
      if fileManager.fileExists(atPath: destURL.path) {
        try fileManager.removeItem(at: destURL)
      }

      // Copy file
      try fileManager.copyItem(at: url, to: destURL)
      return destURL.path
    } catch {
      // Copy failed - caller will try original path
      return nil
    }
  }

  /// Clean old files from OpenIn cache directory
  private func cleanOldFiles(in directory: URL) {
    let fileManager = FileManager.default
    let oneHourAgo = Date().addingTimeInterval(-3600)

    guard let files = try? fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: [.creationDateKey]) else {
      return
    }

    for file in files {
      if let creationDate = try? file.resourceValues(forKeys: [.creationDateKey]).creationDate,
         creationDate < oneHourAgo {
        try? fileManager.removeItem(at: file)
      }
    }
  }

  /// Send file path to Flutter through EventChannel
  private func sendFileToFlutter(path: String, originalName: String) {
    let data: [String: Any] = [
      "path": path,
      "name": originalName,
      "mimeType": getMimeType(for: path)
    ]

    openInFileEventSink?(data)
  }

  /// Get MIME type for file path
  private func getMimeType(for path: String) -> String {
    let ext = (path as NSString).pathExtension.lowercased()
    switch ext {
    case "pdf": return "application/pdf"
    case "jpg", "jpeg": return "image/jpeg"
    case "png": return "image/png"
    case "gif": return "image/gif"
    case "heic", "heif": return "image/heic"
    case "webp": return "image/webp"
    case "bmp": return "image/bmp"
    case "tiff", "tif": return "image/tiff"
    default: return "application/octet-stream"
    }
  }

  private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "createBookmark":
      handleCreateBookmark(call: call, result: result)
    case "resolveBookmark":
      handleResolveBookmark(call: call, result: result)
    case "startAccessing":
      handleStartAccessing(call: call, result: result)
    case "stopAccessing":
      handleStopAccessing(call: call, result: result)
    case "isBookmarkStale":
      handleIsBookmarkStale(call: call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  // MARK: - Settings Channel Handler

  private func handleSettingsMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getString":
      handleGetString(call: call, result: result)
    case "setString":
      handleSetString(call: call, result: result)
    case "getAll":
      handleGetAllSettings(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func handleGetString(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let key = args["key"] as? String else {
      result(FlutterError(code: "INVALID_ARGS", message: "key is required", details: nil))
      return
    }

    let value = UserDefaults.standard.string(forKey: key)
    result(value)
  }

  private func handleSetString(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let key = args["key"] as? String else {
      result(FlutterError(code: "INVALID_ARGS", message: "key is required", details: nil))
      return
    }

    let value = args["value"] as? String

    if let value = value, !value.isEmpty {
      UserDefaults.standard.set(value, forKey: key)
    } else {
      UserDefaults.standard.removeObject(forKey: key)
    }
    UserDefaults.standard.synchronize()
    result(nil)
  }

  private func handleGetAllSettings(result: @escaping FlutterResult) {
    let defaults = UserDefaults.standard
    let settings: [String: Any?] = [
      "locale_preference": defaults.string(forKey: "locale_preference"),
      "size_unit_preference": defaults.string(forKey: "size_unit_preference")
    ]
    result(settings)
  }

  // MARK: - Create Bookmark

  private func handleCreateBookmark(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let filePath = args["filePath"] as? String else {
      result(FlutterError(code: "INVALID_ARGS", message: "filePath is required", details: nil))
      return
    }

    let fileURL = URL(fileURLWithPath: filePath)

    // Start accessing to ensure we have permission before creating bookmark
    let accessing = fileURL.startAccessingSecurityScopedResource()

    do {
      // On iOS, use minimal bookmark - security scope is handled separately
      let bookmarkData = try fileURL.bookmarkData(
        options: .minimalBookmark,
        includingResourceValuesForKeys: nil,
        relativeTo: nil
      )

      if accessing {
        fileURL.stopAccessingSecurityScopedResource()
      }

      let base64String = bookmarkData.base64EncodedString()
      result(base64String)
    } catch {
      if accessing {
        fileURL.stopAccessingSecurityScopedResource()
      }
      result(FlutterError(
        code: "BOOKMARK_CREATION_FAILED",
        message: "Failed to create bookmark: \(error.localizedDescription)",
        details: nil
      ))
    }
  }

  // MARK: - Resolve Bookmark

  private func handleResolveBookmark(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let bookmarkBase64 = args["bookmarkData"] as? String,
          let bookmarkData = Data(base64Encoded: bookmarkBase64) else {
      result(FlutterError(code: "INVALID_ARGS", message: "bookmarkData is required", details: nil))
      return
    }

    do {
      var isStale = false
      let url = try URL(
        resolvingBookmarkData: bookmarkData,
        options: [],
        relativeTo: nil,
        bookmarkDataIsStale: &isStale
      )

      result([
        "path": url.path,
        "isStale": isStale
      ])
    } catch {
      result(FlutterError(
        code: "BOOKMARK_RESOLUTION_FAILED",
        message: "Failed to resolve bookmark: \(error.localizedDescription)",
        details: nil
      ))
    }
  }

  // MARK: - Start/Stop Accessing

  private func handleStartAccessing(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let filePath = args["filePath"] as? String else {
      result(FlutterError(code: "INVALID_ARGS", message: "filePath is required", details: nil))
      return
    }

    let fileURL = URL(fileURLWithPath: filePath)
    let success = fileURL.startAccessingSecurityScopedResource()
    result(success)
  }

  private func handleStopAccessing(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let filePath = args["filePath"] as? String else {
      result(FlutterError(code: "INVALID_ARGS", message: "filePath is required", details: nil))
      return
    }

    let fileURL = URL(fileURLWithPath: filePath)
    fileURL.stopAccessingSecurityScopedResource()
    result(nil)
  }

  // MARK: - Check Stale

  private func handleIsBookmarkStale(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let bookmarkBase64 = args["bookmarkData"] as? String,
          let bookmarkData = Data(base64Encoded: bookmarkBase64) else {
      result(FlutterError(code: "INVALID_ARGS", message: "bookmarkData is required", details: nil))
      return
    }

    do {
      var isStale = false
      let url = try URL(
        resolvingBookmarkData: bookmarkData,
        options: [],
        relativeTo: nil,
        bookmarkDataIsStale: &isStale
      )

      // Also check if file exists
      if !isStale {
        let fileManager = FileManager.default
        isStale = !fileManager.fileExists(atPath: url.path)
      }

      result(isStale)
    } catch {
      result(true)
    }
  }
}

// MARK: - FlutterStreamHandler for EventChannel

extension AppDelegate: FlutterStreamHandler {
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    openInFileEventSink = events

    // Send any pending file from cold start
    if let pendingUrl = pendingOpenInFileUrl {
      if let localPath = copyFileToCache(url: pendingUrl) {
        sendFileToFlutter(path: localPath, originalName: pendingUrl.lastPathComponent)
      } else {
        sendFileToFlutter(path: pendingUrl.path, originalName: pendingUrl.lastPathComponent)
      }
      pendingOpenInFileUrl = nil
    }

    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    openInFileEventSink = nil
    return nil
  }
}
