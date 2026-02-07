import Flutter
import UIKit
import Vision
import CoreImage

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

    // Register background removal channel
    let backgroundRemovalChannel = FlutterMethodChannel(
      name: "com.ivanvaganov.minipdfsign/background_removal",
      binaryMessenger: controller.binaryMessenger
    )
    backgroundRemovalChannel.setMethodCallHandler { [weak self] call, result in
      self?.handleBackgroundRemovalMethodCall(call: call, result: result)
    }

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

  // MARK: - Background Removal

  /// Cached CIContext for better performance (expensive to create)
  private lazy var ciContext: CIContext = {
    return CIContext(options: [.useSoftwareRenderer: false])
  }()

  /// Color tolerance for background removal (0-255 range)
  private let colorTolerance: CGFloat = 35.0

  private func handleBackgroundRemovalMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isAvailable":
      handleIsBackgroundRemovalAvailable(result: result)
    case "removeBackground":
      handleRemoveBackground(call: call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func handleIsBackgroundRemovalAvailable(result: @escaping FlutterResult) {
    // Color-based removal works on iOS 13+
    // ML-based works on iOS 17+ only (iOS 15-16 person segmentation not useful for stamps)
    result(true)
  }

  private func handleRemoveBackground(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let inputPath = args["inputPath"] as? String,
          let outputPath = args["outputPath"] as? String else {
      result(["success": false, "error": "inputPath and outputPath are required"])
      return
    }

    // Extract background color if provided by Dart
    var bgColor: (r: Int, g: Int, b: Int)?
    if let colorMap = args["backgroundColor"] as? [String: Int],
       let r = colorMap["r"], let g = colorMap["g"], let b = colorMap["b"] {
      bgColor = (r, g, b)
    }

    // Run on background queue to not block UI
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else {
        DispatchQueue.main.async {
          result(["success": false, "error": "Instance deallocated"])
        }
        return
      }

      self.performBackgroundRemoval(inputPath: inputPath, outputPath: outputPath, backgroundColor: bgColor) { success, error in
        DispatchQueue.main.async {
          if success {
            result(["success": true, "outputPath": outputPath])
          } else {
            result(["success": false, "error": error ?? "Unknown error"])
          }
        }
      }
    }
  }

  private func performBackgroundRemoval(inputPath: String, outputPath: String, backgroundColor: (r: Int, g: Int, b: Int)?, completion: @escaping (Bool, String?) -> Void) {
    // Load input image with orientation handling
    guard let inputImage = UIImage(contentsOfFile: inputPath) else {
      completion(false, "Failed to load input image")
      return
    }

    // Normalize orientation - draw into new context to flatten orientation
    let normalizedImage = normalizeImageOrientation(inputImage)

    guard let cgImage = normalizedImage.cgImage else {
      completion(false, "Failed to get CGImage")
      return
    }

    if #available(iOS 17.0, *) {
      // Try ML-based segmentation first (iOS 17+)
      performForegroundInstanceMask(cgImage: cgImage, outputPath: outputPath, backgroundColor: backgroundColor, completion: completion)
    } else {
      // iOS 15-16: Use color-based removal (person segmentation doesn't work for stamps)
      performColorBasedRemoval(cgImage: cgImage, outputPath: outputPath, backgroundColor: backgroundColor, completion: completion)
    }
  }

  /// Normalizes UIImage orientation by drawing into a new context
  private func normalizeImageOrientation(_ image: UIImage) -> UIImage {
    if image.imageOrientation == .up {
      return image
    }

    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
    image.draw(in: CGRect(origin: .zero, size: image.size))
    let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return normalizedImage ?? image
  }

  /// Confidence threshold for sharp edges (0.5 = 50% confidence)
  /// Pixels above this threshold are fully opaque, below are fully transparent
  private let confidenceThreshold: Float = 0.5

  @available(iOS 17.0, *)
  private func performForegroundInstanceMask(cgImage: CGImage, outputPath: String, backgroundColor: (r: Int, g: Int, b: Int)?, completion: @escaping (Bool, String?) -> Void) {
    let request = VNGenerateForegroundInstanceMaskRequest()
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

    do {
      try handler.perform([request])

      guard let observation = request.results?.first,
            !observation.allInstances.isEmpty else {
        // No foreground detected - fallback to color-based removal
        performColorBasedRemoval(cgImage: cgImage, outputPath: outputPath, backgroundColor: backgroundColor, completion: completion)
        return
      }

      // Get scaled mask for the image (raw confidence values)
      let maskPixelBuffer = try observation.generateScaledMaskForImage(
        forInstances: observation.allInstances,
        from: handler
      )

      // Apply threshold to mask and composite with original image for sharp edges
      guard let maskedImage = applyThresholdMask(to: cgImage, mask: maskPixelBuffer) else {
        // Fallback to color-based
        performColorBasedRemoval(cgImage: cgImage, outputPath: outputPath, backgroundColor: backgroundColor, completion: completion)
        return
      }

      // Post-ML: remove background-colored pixels inside enclosed areas (stamps)
      let outputCGImage = removeBackgroundColorFromMaskedImage(maskedImage, originalImage: cgImage, backgroundColor: backgroundColor) ?? maskedImage

      let outputImage = UIImage(cgImage: outputCGImage)
      guard let pngData = outputImage.pngData() else {
        completion(false, "Failed to encode PNG")
        return
      }

      do {
        try pngData.write(to: URL(fileURLWithPath: outputPath))
        completion(true, nil)
      } catch {
        completion(false, "Failed to write output: \(error.localizedDescription)")
      }

    } catch {
      // ML failed - fallback to color-based removal
      performColorBasedRemoval(cgImage: cgImage, outputPath: outputPath, backgroundColor: backgroundColor, completion: completion)
    }
  }

  /// Apply threshold-based mask to image for sharp edges instead of soft/blurry edges.
  /// This is better for stamps and signatures that need crisp boundaries.
  private func applyThresholdMask(to cgImage: CGImage, mask: CVPixelBuffer) -> CGImage? {
    let width = cgImage.width
    let height = cgImage.height

    // Create output context with alpha
    guard let context = CGContext(
      data: nil,
      width: width,
      height: height,
      bitsPerComponent: 8,
      bytesPerRow: width * 4,
      space: CGColorSpaceCreateDeviceRGB(),
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
      return nil
    }

    // Draw original image
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

    guard let pixelData = context.data else {
      return nil
    }

    let pixels = pixelData.bindMemory(to: UInt8.self, capacity: width * height * 4)

    // Lock mask buffer and get pointer to mask data
    CVPixelBufferLockBaseAddress(mask, .readOnly)
    defer { CVPixelBufferUnlockBaseAddress(mask, .readOnly) }

    let maskWidth = CVPixelBufferGetWidth(mask)
    let maskHeight = CVPixelBufferGetHeight(mask)
    let maskBytesPerRow = CVPixelBufferGetBytesPerRow(mask)

    guard let maskBaseAddress = CVPixelBufferGetBaseAddress(mask) else {
      return nil
    }

    let maskPixels = maskBaseAddress.assumingMemoryBound(to: Float.self)

    // Apply threshold mask - binary decision for sharp edges
    for y in 0..<height {
      for x in 0..<width {
        // Map image coordinates to mask coordinates
        let maskX = x * maskWidth / width
        let maskY = y * maskHeight / height
        let maskIndex = maskY * (maskBytesPerRow / MemoryLayout<Float>.size) + maskX

        let confidence = maskPixels[maskIndex]

        let pixelOffset = (y * width + x) * 4

        if confidence < confidenceThreshold {
          // Below threshold - make fully transparent
          pixels[pixelOffset + 3] = 0
        }
        // Above threshold - keep fully opaque (alpha unchanged from original)
      }
    }

    return context.makeImage()
  }

  /// Post-ML cleanup: remove background-colored pixels that ML kept inside enclosed areas (e.g. inside round stamps).
  private func removeBackgroundColorFromMaskedImage(_ cgImage: CGImage, originalImage: CGImage, backgroundColor: (r: Int, g: Int, b: Int)?) -> CGImage? {
    let width = cgImage.width
    let height = cgImage.height

    guard let context = CGContext(
      data: nil, width: width, height: height,
      bitsPerComponent: 8, bytesPerRow: width * 4,
      space: CGColorSpaceCreateDeviceRGB(),
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ), let pixelData = context.data else { return nil }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    let pixels = pixelData.bindMemory(to: UInt8.self, capacity: width * height * 4)

    // Detect background color from ORIGINAL image (before ML removed outer background)
    let bgColor: (r: CGFloat, g: CGFloat, b: CGFloat)
    if let provided = backgroundColor {
      bgColor = (CGFloat(provided.r), CGFloat(provided.g), CGFloat(provided.b))
    } else {
      bgColor = detectBackgroundColor(cgImage: originalImage)
    }

    // For each OPAQUE pixel, check if it matches background color
    for y in 0..<height {
      for x in 0..<width {
        let offset = (y * width + x) * 4
        let alpha = pixels[offset + 3]
        guard alpha > 0 else { continue }

        let r = CGFloat(pixels[offset])
        let g = CGFloat(pixels[offset + 1])
        let b = CGFloat(pixels[offset + 2])
        let distance = sqrt(pow(r - bgColor.r, 2) + pow(g - bgColor.g, 2) + pow(b - bgColor.b, 2))

        if distance < colorTolerance {
          pixels[offset + 3] = 0
        }
      }
    }

    return context.makeImage()
  }

  /// Color-based background removal - works for uniform backgrounds like white paper
  private func performColorBasedRemoval(cgImage: CGImage, outputPath: String, backgroundColor: (r: Int, g: Int, b: Int)?, completion: @escaping (Bool, String?) -> Void) {

    let width = cgImage.width
    let height = cgImage.height

    // Detect background color from corners if not provided
    let bgColor: (r: CGFloat, g: CGFloat, b: CGFloat)
    if let provided = backgroundColor {
      bgColor = (CGFloat(provided.r), CGFloat(provided.g), CGFloat(provided.b))
    } else {
      bgColor = detectBackgroundColor(cgImage: cgImage)
    }

    // Create bitmap context
    guard let context = CGContext(
      data: nil,
      width: width,
      height: height,
      bitsPerComponent: 8,
      bytesPerRow: width * 4,
      space: CGColorSpaceCreateDeviceRGB(),
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
      completion(false, "Failed to create bitmap context")
      return
    }

    // Draw original image
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

    guard let pixelData = context.data else {
      completion(false, "Failed to get pixel data")
      return
    }

    let pixels = pixelData.bindMemory(to: UInt8.self, capacity: width * height * 4)

    // Process pixels - make background transparent
    for y in 0..<height {
      for x in 0..<width {
        let offset = (y * width + x) * 4
        let r = CGFloat(pixels[offset])
        let g = CGFloat(pixels[offset + 1])
        let b = CGFloat(pixels[offset + 2])

        // Calculate color distance
        let distance = sqrt(
          pow(r - bgColor.r, 2) +
          pow(g - bgColor.g, 2) +
          pow(b - bgColor.b, 2)
        )

        if distance < colorTolerance {
          // Make transparent
          pixels[offset + 3] = 0 // Alpha = 0
        }
      }
    }

    // Create output image
    guard let outputCGImage = context.makeImage() else {
      completion(false, "Failed to create output image")
      return
    }

    let outputImage = UIImage(cgImage: outputCGImage)
    guard let pngData = outputImage.pngData() else {
      completion(false, "Failed to encode PNG")
      return
    }

    do {
      try pngData.write(to: URL(fileURLWithPath: outputPath))
      completion(true, nil)
    } catch {
      completion(false, "Failed to write output: \(error.localizedDescription)")
    }
  }

  /// Detects background color by sampling corners of the image
  private func detectBackgroundColor(cgImage: CGImage) -> (r: CGFloat, g: CGFloat, b: CGFloat) {
    let width = cgImage.width
    let height = cgImage.height

    guard let context = CGContext(
      data: nil,
      width: width,
      height: height,
      bitsPerComponent: 8,
      bytesPerRow: width * 4,
      space: CGColorSpaceCreateDeviceRGB(),
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ), let pixelData = context.data else {
      return (255, 255, 255) // Default to white
    }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    let pixels = pixelData.bindMemory(to: UInt8.self, capacity: width * height * 4)

    // Sample corners
    let corners = [
      (0, 0), (width - 1, 0),
      (0, height - 1), (width - 1, height - 1)
    ]

    var totalR: CGFloat = 0
    var totalG: CGFloat = 0
    var totalB: CGFloat = 0

    for (x, y) in corners {
      let offset = (y * width + x) * 4
      totalR += CGFloat(pixels[offset])
      totalG += CGFloat(pixels[offset + 1])
      totalB += CGFloat(pixels[offset + 2])
    }

    return (totalR / 4, totalG / 4, totalB / 4)
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
