package com.ivanvaganov.minipdfsign

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.util.Base64
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.segmentation.subject.SubjectSegmentation
import com.google.mlkit.vision.segmentation.subject.SubjectSegmenterOptions
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream
import java.nio.FloatBuffer

class MainActivity : FlutterActivity() {
    private val BOOKMARK_CHANNEL = "com.ivanvaganov.minipdfsign/file_bookmarks"
    private val SETTINGS_CHANNEL = "com.ivanvaganov.minipdfsign/settings"
    private val BACKGROUND_REMOVAL_CHANNEL = "com.ivanvaganov.minipdfsign/background_removal"

    // Use a custom SharedPreferences file (not flutter's default)
    // to avoid the "flutter." prefix that shared_preferences plugin uses
    private val settingsPrefs: SharedPreferences by lazy {
        getSharedPreferences("app_settings", Context.MODE_PRIVATE)
    }

    // ML Kit Subject Segmenter
    private val subjectSegmenter by lazy {
        val options = SubjectSegmenterOptions.Builder()
            .enableForegroundConfidenceMask()
            .build()
        SubjectSegmentation.getClient(options)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Settings channel for native SharedPreferences access
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SETTINGS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getString" -> handleGetString(call.argument("key"), result)
                "setString" -> handleSetString(call.argument("key"), call.argument("value"), result)
                "getAll" -> handleGetAllSettings(result)
                else -> result.notImplemented()
            }
        }

        // File bookmarks channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BOOKMARK_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "createBookmark" -> handleCreateBookmark(call.argument("filePath"), call.argument("contentUri"), result)
                "resolveBookmark" -> handleResolveBookmark(call.argument("bookmarkData"), result)
                "startAccessing" -> handleStartAccessing(call.argument("filePath"), result)
                "stopAccessing" -> handleStopAccessing(call.argument("filePath"), result)
                "isBookmarkStale" -> handleIsBookmarkStale(call.argument("bookmarkData"), result)
                else -> result.notImplemented()
            }
        }

        // Background removal channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BACKGROUND_REMOVAL_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isAvailable" -> handleIsBackgroundRemovalAvailable(result)
                "removeBackground" -> {
                    // Parse optional background color
                    val bgColorMap = call.argument<Map<String, Int>>("backgroundColor")
                    val bgColor = if (bgColorMap != null) {
                        val r = bgColorMap["r"] ?: 255
                        val g = bgColorMap["g"] ?: 255
                        val b = bgColorMap["b"] ?: 255
                        Triple(r, g, b)
                    } else null

                    handleRemoveBackgroundWithColor(
                        call.argument("inputPath"),
                        call.argument("outputPath"),
                        bgColor,
                        result
                    )
                }
                else -> result.notImplemented()
            }
        }
    }

    /**
     * Creates a "bookmark" for Android by taking persistable URI permission.
     *
     * On Android, we store the content URI itself (not a separate bookmark data)
     * because persistable permissions are tied to the URI.
     */
    private fun handleCreateBookmark(filePath: String?, contentUri: String?, result: MethodChannel.Result) {
        try {
            // On Android, the "bookmark" is the content URI with persistable permission
            val uriString = contentUri ?: filePath
            if (uriString == null) {
                result.error("INVALID_ARGS", "filePath or contentUri is required", null)
                return
            }

            val uri = Uri.parse(uriString)

            // Try to take persistable permission if it's a content URI
            if (uri.scheme == "content") {
                try {
                    contentResolver.takePersistableUriPermission(
                        uri,
                        Intent.FLAG_GRANT_READ_URI_PERMISSION
                    )
                } catch (e: SecurityException) {
                    // Permission might already be taken or not available
                    // This is not necessarily an error - the URI might still work
                }
            }

            // Encode the URI as the "bookmark data"
            val bookmarkData = Base64.encodeToString(uriString.toByteArray(Charsets.UTF_8), Base64.NO_WRAP)
            result.success(bookmarkData)

        } catch (e: Exception) {
            result.error("BOOKMARK_CREATION_FAILED", "Failed to create bookmark: ${e.message}", null)
        }
    }

    /**
     * Resolves a bookmark back to a usable URI/path.
     */
    private fun handleResolveBookmark(bookmarkData: String?, result: MethodChannel.Result) {
        try {
            if (bookmarkData == null) {
                result.error("INVALID_ARGS", "bookmarkData is required", null)
                return
            }

            // Decode the bookmark data to get the URI
            val uriString = String(Base64.decode(bookmarkData, Base64.NO_WRAP), Charsets.UTF_8)
            val uri = Uri.parse(uriString)

            // Check if we have permission
            val isStale = !hasUriPermission(uri)

            result.success(mapOf(
                "path" to uriString,
                "isStale" to isStale
            ))

        } catch (e: Exception) {
            result.error("BOOKMARK_RESOLUTION_FAILED", "Failed to resolve bookmark: ${e.message}", null)
        }
    }

    /**
     * Checks if we have persistable permission for a content URI.
     */
    private fun hasUriPermission(uri: Uri): Boolean {
        if (uri.scheme != "content") {
            // For file:// URIs, check if file exists
            return try {
                val path = uri.path
                if (path != null) {
                    java.io.File(path).exists()
                } else {
                    false
                }
            } catch (e: Exception) {
                false
            }
        }

        // Check persistable permissions for content URIs
        val persistedUris = contentResolver.persistedUriPermissions
        return persistedUris.any { it.uri == uri && it.isReadPermission }
    }

    /**
     * Start accessing a file - on Android this is a no-op for content URIs
     * as permission is already taken. For file paths, we check accessibility.
     */
    private fun handleStartAccessing(filePath: String?, result: MethodChannel.Result) {
        try {
            if (filePath == null) {
                result.error("INVALID_ARGS", "filePath is required", null)
                return
            }

            val uri = Uri.parse(filePath)

            // For content URIs, check if we have permission
            if (uri.scheme == "content") {
                val hasPermission = hasUriPermission(uri)
                result.success(hasPermission)
            } else {
                // For file paths, check if file exists and is readable
                val file = java.io.File(uri.path ?: filePath)
                result.success(file.exists() && file.canRead())
            }

        } catch (e: Exception) {
            result.success(false)
        }
    }

    /**
     * Stop accessing a file - on Android this is a no-op.
     * Persistable permissions remain until explicitly released.
     */
    private fun handleStopAccessing(filePath: String?, result: MethodChannel.Result) {
        // No-op on Android - permissions persist automatically
        result.success(null)
    }

    /**
     * Check if a bookmark is stale (no longer valid).
     */
    private fun handleIsBookmarkStale(bookmarkData: String?, result: MethodChannel.Result) {
        try {
            if (bookmarkData == null) {
                result.success(true)
                return
            }

            val uriString = String(Base64.decode(bookmarkData, Base64.NO_WRAP), Charsets.UTF_8)
            val uri = Uri.parse(uriString)

            result.success(!hasUriPermission(uri))

        } catch (e: Exception) {
            result.success(true)
        }
    }

    // MARK: - Settings Methods

    /**
     * Get a string value from native SharedPreferences.
     */
    private fun handleGetString(key: String?, result: MethodChannel.Result) {
        if (key == null) {
            result.error("INVALID_ARGS", "key is required", null)
            return
        }
        val value = settingsPrefs.getString(key, null)
        result.success(value)
    }

    /**
     * Set a string value in native SharedPreferences.
     */
    private fun handleSetString(key: String?, value: String?, result: MethodChannel.Result) {
        if (key == null) {
            result.error("INVALID_ARGS", "key is required", null)
            return
        }

        val editor = settingsPrefs.edit()
        if (value.isNullOrEmpty()) {
            editor.remove(key)
        } else {
            editor.putString(key, value)
        }
        editor.apply()
        result.success(null)
    }

    /**
     * Get all settings values.
     */
    private fun handleGetAllSettings(result: MethodChannel.Result) {
        val settings = mapOf(
            "locale_preference" to settingsPrefs.getString("locale_preference", null),
            "size_unit_preference" to settingsPrefs.getString("size_unit_preference", null)
        )
        result.success(settings)
    }

    // MARK: - Background Removal Methods

    /** Color tolerance for background removal (0-255 range) */
    private val colorTolerance = 35

    /**
     * Check if background removal is available.
     * Color-based removal works on all Android versions.
     */
    private fun handleIsBackgroundRemovalAvailable(result: MethodChannel.Result) {
        result.success(true)
    }

    /**
     * Remove background from an image.
     * Uses ML Kit Subject Segmentation on API 24+, with color-based fallback.
     */
    private fun handleRemoveBackground(inputPath: String?, outputPath: String?, result: MethodChannel.Result) {
        handleRemoveBackgroundWithColor(inputPath, outputPath, null, result)
    }

    /**
     * Remove background with optional background color hint from Dart.
     */
    private fun handleRemoveBackgroundWithColor(
        inputPath: String?,
        outputPath: String?,
        backgroundColor: Triple<Int, Int, Int>?,
        result: MethodChannel.Result
    ) {
        if (inputPath == null || outputPath == null) {
            result.success(mapOf("success" to false, "error" to "inputPath and outputPath are required"))
            return
        }

        // Run on background thread
        Thread {
            try {
                val inputFile = File(inputPath)
                if (!inputFile.exists()) {
                    runOnUiThread {
                        result.success(mapOf("success" to false, "error" to "Input file not found"))
                    }
                    return@Thread
                }

                val bitmap = BitmapFactory.decodeFile(inputPath)
                if (bitmap == null) {
                    runOnUiThread {
                        result.success(mapOf("success" to false, "error" to "Failed to decode input image"))
                    }
                    return@Thread
                }

                // Try ML Kit first on API 24+
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    tryMLKitSegmentation(bitmap, outputPath, backgroundColor, result)
                } else {
                    // Fallback to color-based removal
                    performColorBasedRemoval(bitmap, outputPath, backgroundColor, result)
                }

            } catch (e: Exception) {
                runOnUiThread {
                    result.success(mapOf("success" to false, "error" to "Error: ${e.message}"))
                }
            }
        }.start()
    }

    /**
     * Try ML Kit subject segmentation, fallback to color-based on failure.
     */
    private fun tryMLKitSegmentation(
        bitmap: Bitmap,
        outputPath: String,
        backgroundColor: Triple<Int, Int, Int>?,
        result: MethodChannel.Result
    ) {
        val inputImage = InputImage.fromBitmap(bitmap, 0)

        subjectSegmenter.process(inputImage)
            .addOnSuccessListener { segmentationResult ->
                val mask = segmentationResult.foregroundConfidenceMask
                if (mask == null) {
                    // No subject detected - fallback to color-based
                    performColorBasedRemoval(bitmap, outputPath, backgroundColor, result)
                    return@addOnSuccessListener
                }

                Thread {
                    try {
                        // Apply mask using bulk operations
                        val outputBitmap = applyMaskToBitmapFast(bitmap, mask)

                        // Save as PNG
                        val outputFile = File(outputPath)
                        FileOutputStream(outputFile).use { out ->
                            outputBitmap.compress(Bitmap.CompressFormat.PNG, 100, out)
                        }

                        outputBitmap.recycle()
                        bitmap.recycle()

                        runOnUiThread {
                            result.success(mapOf("success" to true, "outputPath" to outputPath))
                        }
                    } catch (e: Exception) {
                        bitmap.recycle()
                        runOnUiThread {
                            result.success(mapOf("success" to false, "error" to "Failed to save: ${e.message}"))
                        }
                    }
                }.start()
            }
            .addOnFailureListener {
                // ML Kit failed - fallback to color-based removal
                performColorBasedRemoval(bitmap, outputPath, backgroundColor, result)
            }
    }

    /**
     * Apply confidence mask to bitmap using BULK operations for performance.
     * ~100x faster than pixel-by-pixel operations.
     *
     * Uses threshold-based alpha to produce sharp edges instead of soft/blurry edges.
     * This is better for stamps and signatures that need crisp boundaries.
     */
    private fun applyMaskToBitmapFast(original: Bitmap, mask: FloatBuffer): Bitmap {
        val width = original.width
        val height = original.height
        val pixelCount = width * height

        // Bulk read all pixels
        val pixels = IntArray(pixelCount)
        original.getPixels(pixels, 0, width, 0, 0, width, height)

        // Convert mask to array for faster access
        mask.rewind()
        val maskArray = FloatArray(minOf(mask.capacity(), pixelCount))
        mask.get(maskArray, 0, maskArray.size)

        // Confidence threshold for sharp edges (0.5 = 50% confidence)
        // Pixels above this threshold are fully opaque, below are fully transparent
        val confidenceThreshold = 0.5f

        // Process all pixels with threshold-based alpha for sharp edges
        for (i in 0 until pixelCount) {
            val confidence = if (i < maskArray.size) maskArray[i] else 0f

            if (confidence >= confidenceThreshold) {
                // Keep pixel fully opaque (sharp edge)
                val pixel = pixels[i]
                pixels[i] = Color.argb(
                    255,
                    Color.red(pixel),
                    Color.green(pixel),
                    Color.blue(pixel)
                )
            } else {
                // Make fully transparent
                pixels[i] = Color.TRANSPARENT
            }
        }

        // Bulk write all pixels
        val output = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        output.setPixels(pixels, 0, width, 0, 0, width, height)

        return output
    }

    /**
     * Color-based background removal - works for uniform backgrounds like white paper.
     */
    private fun performColorBasedRemoval(
        bitmap: Bitmap,
        outputPath: String,
        backgroundColor: Triple<Int, Int, Int>?,
        result: MethodChannel.Result
    ) {
        Thread {
            try {
                val width = bitmap.width
                val height = bitmap.height
                val pixelCount = width * height

                // Bulk read all pixels
                val pixels = IntArray(pixelCount)
                bitmap.getPixels(pixels, 0, width, 0, 0, width, height)

                // Detect or use provided background color
                val bgColor = backgroundColor ?: detectBackgroundColor(pixels, width, height)

                // Process pixels - make background transparent
                for (i in 0 until pixelCount) {
                    val pixel = pixels[i]
                    val r = Color.red(pixel)
                    val g = Color.green(pixel)
                    val b = Color.blue(pixel)

                    // Calculate color distance
                    val distance = kotlin.math.sqrt(
                        ((r - bgColor.first) * (r - bgColor.first) +
                         (g - bgColor.second) * (g - bgColor.second) +
                         (b - bgColor.third) * (b - bgColor.third)).toDouble()
                    )

                    if (distance < colorTolerance) {
                        // Make transparent
                        pixels[i] = Color.TRANSPARENT
                    }
                }

                // Create output bitmap and bulk write
                val output = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
                output.setPixels(pixels, 0, width, 0, 0, width, height)

                // Save as PNG
                val outputFile = File(outputPath)
                FileOutputStream(outputFile).use { out ->
                    output.compress(Bitmap.CompressFormat.PNG, 100, out)
                }

                output.recycle()
                bitmap.recycle()

                runOnUiThread {
                    result.success(mapOf("success" to true, "outputPath" to outputPath))
                }

            } catch (e: Exception) {
                bitmap.recycle()
                runOnUiThread {
                    result.success(mapOf("success" to false, "error" to "Color removal failed: ${e.message}"))
                }
            }
        }.start()
    }

    /**
     * Detect background color by sampling corners of the image.
     */
    private fun detectBackgroundColor(pixels: IntArray, width: Int, height: Int): Triple<Int, Int, Int> {
        // Sample corners
        val corners = listOf(
            0,                          // top-left
            width - 1,                  // top-right
            (height - 1) * width,       // bottom-left
            (height - 1) * width + width - 1  // bottom-right
        )

        var totalR = 0
        var totalG = 0
        var totalB = 0

        for (index in corners) {
            if (index < pixels.size) {
                val pixel = pixels[index]
                totalR += Color.red(pixel)
                totalG += Color.green(pixel)
                totalB += Color.blue(pixel)
            }
        }

        return Triple(totalR / 4, totalG / 4, totalB / 4)
    }
}
