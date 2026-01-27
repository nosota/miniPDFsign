import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Register file bookmark handler for security-scoped bookmarks
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "com.ivanvaganov.minipdfsign/file_bookmarks",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { [weak self] call, result in
      self?.handleMethodCall(call: call, result: result)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
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
