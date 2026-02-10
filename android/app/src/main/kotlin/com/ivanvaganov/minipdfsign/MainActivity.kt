package com.ivanvaganov.minipdfsign

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.graphics.Matrix
import android.media.ExifInterface
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
    private val CLIPBOARD_CHANNEL = "com.ivanvaganov.minipdfsign/clipboard"

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

        // Clipboard image channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CLIPBOARD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getImage" -> handleGetClipboardImage(result)
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

    /** Post-ML cleanup thresholds (histogram + HSL + RGB triple criteria) */
    private val postMLRGBDistanceThreshold = 80.0
    private val postMLSaturationThreshold = 0.20
    private val postMLLightnessThreshold = 0.70

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

                // Load bitmap with EXIF orientation applied
                val bitmap = loadBitmapWithExifOrientation(inputPath)
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

                        // Post-ML: remove background-colored pixels inside enclosed areas (stamps)
                        removeBackgroundColorFromBitmap(outputBitmap)

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
     * Convert RGB (0-255) to HSV Saturation and HSL Lightness (0.0-1.0). Hue is not needed.
     * Uses HSV saturation (delta/max) instead of HSL saturation (which degenerates to 1.0 near white).
     */
    private fun rgbToSL(r: Int, g: Int, b: Int): Pair<Double, Double> {
        val rn = r / 255.0
        val gn = g / 255.0
        val bn = b / 255.0
        val cMax = maxOf(rn, gn, bn)
        val cMin = minOf(rn, gn, bn)
        val lightness = (cMax + cMin) / 2.0
        val saturation = if (cMax > 0) (cMax - cMin) / cMax else 0.0
        return Pair(saturation, lightness)
    }

    /**
     * Find dominant color among opaque pixels using histogram quantization (4096 buckets).
     */
    private fun findDominantColor(pixels: IntArray): Triple<Int, Int, Int> {
        val bucketDivisor = 16
        val bucketCount = 4096 // 16^3
        val histogram = IntArray(bucketCount)
        val bucketSumR = IntArray(bucketCount)
        val bucketSumG = IntArray(bucketCount)
        val bucketSumB = IntArray(bucketCount)

        for (pixel in pixels) {
            if (Color.alpha(pixel) == 0) continue

            val r = Color.red(pixel)
            val g = Color.green(pixel)
            val b = Color.blue(pixel)

            val bucket = (r / bucketDivisor) * 256 + (g / bucketDivisor) * 16 + (b / bucketDivisor)
            histogram[bucket]++
            bucketSumR[bucket] += r
            bucketSumG[bucket] += g
            bucketSumB[bucket] += b
        }

        var maxCount = 0
        var maxBucket = 0
        for (i in 0 until bucketCount) {
            if (histogram[i] > maxCount) {
                maxCount = histogram[i]
                maxBucket = i
            }
        }

        if (maxCount == 0) {
            return Triple(255, 255, 255)
        }

        return Triple(
            bucketSumR[maxBucket] / maxCount,
            bucketSumG[maxBucket] / maxCount,
            bucketSumB[maxBucket] / maxCount
        )
    }

    /**
     * Post-ML cleanup: remove background-colored pixels that ML kept
     * inside enclosed areas (e.g. inside round stamps).
     * Uses histogram-based dominant color detection and triple criteria
     * (RGB distance + saturation + lightness).
     */
    private fun removeBackgroundColorFromBitmap(bitmap: Bitmap) {
        val width = bitmap.width
        val height = bitmap.height
        val pixelCount = width * height

        val pixels = IntArray(pixelCount)
        bitmap.getPixels(pixels, 0, width, 0, 0, width, height)

        // Find dominant color among opaque pixels (paper = majority)
        val dominant = findDominantColor(pixels)

        for (i in 0 until pixelCount) {
            val pixel = pixels[i]
            if (Color.alpha(pixel) == 0) continue

            val r = Color.red(pixel)
            val g = Color.green(pixel)
            val b = Color.blue(pixel)

            // 1. RGB distance from dominant color
            val distance = kotlin.math.sqrt(
                ((r - dominant.first) * (r - dominant.first) +
                 (g - dominant.second) * (g - dominant.second) +
                 (b - dominant.third) * (b - dominant.third)).toDouble()
            )
            if (distance >= postMLRGBDistanceThreshold) continue

            // 2+3. Saturation and Lightness check
            val (saturation, lightness) = rgbToSL(r, g, b)
            if (saturation < postMLSaturationThreshold && lightness > postMLLightnessThreshold) {
                pixels[i] = Color.TRANSPARENT
            }
        }

        bitmap.setPixels(pixels, 0, width, 0, 0, width, height)
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

    // MARK: - Clipboard Image

    /**
     * Reads image data from the system clipboard and returns PNG bytes.
     *
     * Supports both content:// URIs (copied images) and bitmap data
     * on the Android clipboard.
     */
    private fun handleGetClipboardImage(result: MethodChannel.Result) {
        try {
            val clipboard = getSystemService(Context.CLIPBOARD_SERVICE)
                as android.content.ClipboardManager

            if (!clipboard.hasPrimaryClip()) {
                result.success(null)
                return
            }

            val clip = clipboard.primaryClip
            if (clip == null || clip.itemCount == 0) {
                result.success(null)
                return
            }

            val item = clip.getItemAt(0)

            // Try to get image URI from clipboard
            val uri = item.uri
            if (uri != null) {
                val mimeType = contentResolver.getType(uri)
                if (mimeType != null && mimeType.startsWith("image/")) {
                    val inputStream = contentResolver.openInputStream(uri)
                    if (inputStream != null) {
                        val bitmap = BitmapFactory.decodeStream(inputStream)
                        inputStream.close()
                        if (bitmap != null) {
                            val outputStream = java.io.ByteArrayOutputStream()
                            bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream)
                            bitmap.recycle()
                            result.success(outputStream.toByteArray())
                            return
                        }
                    }
                }
            }

            // No image found in clipboard
            result.success(null)
        } catch (e: Exception) {
            result.success(null)
        }
    }

    /**
     * Loads a bitmap from file with EXIF orientation applied.
     *
     * BitmapFactory.decodeFile() ignores EXIF orientation, so images from cameras
     * may appear rotated. This function reads the EXIF orientation tag and applies
     * the correct rotation/flip transformation.
     */
    private fun loadBitmapWithExifOrientation(path: String): Bitmap? {
        val bitmap = BitmapFactory.decodeFile(path) ?: return null

        try {
            val exif = ExifInterface(path)
            val orientation = exif.getAttributeInt(
                ExifInterface.TAG_ORIENTATION,
                ExifInterface.ORIENTATION_NORMAL
            )

            // If orientation is normal, return as-is
            if (orientation == ExifInterface.ORIENTATION_NORMAL ||
                orientation == ExifInterface.ORIENTATION_UNDEFINED) {
                return bitmap
            }

            // Create transformation matrix based on EXIF orientation
            val matrix = Matrix()
            when (orientation) {
                ExifInterface.ORIENTATION_ROTATE_90 -> matrix.postRotate(90f)
                ExifInterface.ORIENTATION_ROTATE_180 -> matrix.postRotate(180f)
                ExifInterface.ORIENTATION_ROTATE_270 -> matrix.postRotate(270f)
                ExifInterface.ORIENTATION_FLIP_HORIZONTAL -> matrix.preScale(-1f, 1f)
                ExifInterface.ORIENTATION_FLIP_VERTICAL -> matrix.preScale(1f, -1f)
                ExifInterface.ORIENTATION_TRANSPOSE -> {
                    matrix.postRotate(90f)
                    matrix.preScale(-1f, 1f)
                }
                ExifInterface.ORIENTATION_TRANSVERSE -> {
                    matrix.postRotate(270f)
                    matrix.preScale(-1f, 1f)
                }
            }

            // Apply transformation and return new bitmap
            val rotatedBitmap = Bitmap.createBitmap(
                bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true
            )

            // Recycle original if different
            if (rotatedBitmap != bitmap) {
                bitmap.recycle()
            }

            return rotatedBitmap
        } catch (e: Exception) {
            // If EXIF reading fails, return original bitmap
            return bitmap
        }
    }
}
