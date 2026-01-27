package com.ivanvaganov.minipdfsign

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Base64
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.ivanvaganov.minipdfsign/file_bookmarks"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "createBookmark" -> handleCreateBookmark(call.argument("filePath"), call.argument("contentUri"), result)
                "resolveBookmark" -> handleResolveBookmark(call.argument("bookmarkData"), result)
                "startAccessing" -> handleStartAccessing(call.argument("filePath"), result)
                "stopAccessing" -> handleStopAccessing(call.argument("filePath"), result)
                "isBookmarkStale" -> handleIsBookmarkStale(call.argument("bookmarkData"), result)
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
}
