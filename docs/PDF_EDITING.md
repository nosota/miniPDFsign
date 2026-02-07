# PDF Editing System

This document describes the PDF editing architecture - how images are placed, manipulated, and saved.

## Overview

miniPDFSign allows users to place images (signatures, stamps) on PDF documents. Users can also open images, which are converted to A4 PDFs. The editing system consists of:

1. **Image Library** - Collection of reusable images
2. **Image Validation & Normalization** - Format/size checks, EXIF orientation handling
3. **Placement System** - Drag-and-drop onto PDF pages
4. **Transform Controls** - Move, resize, rotate placed images
5. **Save System** - Embed images into PDF
6. **Image-to-PDF Conversion** - Convert images to A4 PDFs for editing

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    PdfViewerScreen                           │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    PdfViewer                         │    │
│  │  ┌───────────────────────────────────────────────┐  │    │
│  │  │              PdfPageList                       │  │    │
│  │  │  ┌─────────┐ ┌─────────┐ ┌─────────┐         │  │    │
│  │  │  │  Page 1 │ │  Page 2 │ │  Page 3 │  ...    │  │    │
│  │  │  └─────────┘ └─────────┘ └─────────┘         │  │    │
│  │  └───────────────────────────────────────────────┘  │    │
│  │  ┌───────────────────────────────────────────────┐  │    │
│  │  │           PlacedImagesLayer                    │  │    │
│  │  │  ┌──────────────┐  ┌──────────────┐           │  │    │
│  │  │  │ PlacedImage  │  │ PlacedImage  │           │  │    │
│  │  │  │  (selected)  │  │              │           │  │    │
│  │  │  └──────────────┘  └──────────────┘           │  │    │
│  │  └───────────────────────────────────────────────┘  │    │
│  └─────────────────────────────────────────────────────┘    │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              ImageLibrarySheet                       │    │
│  │  ┌────┐ ┌────┐ ┌────┐ ┌────┐                        │    │
│  │  │ img│ │ img│ │ img│ │ +  │  (draggable)           │    │
│  │  └────┘ └────┘ └────┘ └────┘                        │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

## Image Library

### Storage

Images are stored using Isar database:

```dart
@collection
class SidebarImageModel {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true, type: IndexType.hash)
  late String id;           // UUID
  late String filePath;     // App storage path
  late String fileName;     // Display name
  @Index()
  late DateTime addedAt;    // Sort order
  late int width;           // Pixels (after EXIF normalization)
  late int height;
  late int fileSize;
}
```

### Adding Images

1. User taps "+" button in ImageLibrarySheet
2. ImagePickerService opens file picker, photo gallery, or camera
3. ImageValidationService validates and normalizes:
   - File exists
   - Supported format (PNG, JPG, GIF, WEBP, BMP, TIFF, HEIC)
   - File size <= 50MB
   - Resolution <= 4096x4096 (after EXIF orientation)
   - EXIF orientation baked into pixels (via ImageNormalizationService)
4. BackgroundDetectionService analyzes image for uniform background
5. If uniform background detected -> prompt user to remove it
6. If user accepts -> BackgroundRemovalService removes background
7. ImageStorageService copies to app storage with UUID filename
8. SidebarImageRepository adds to Isar database
9. Stream updates UI automatically

### EXIF Normalization

`ImageNormalizationService` handles camera images with EXIF orientation tags:

```
EXIF Orientation values:
1 = Normal (no rotation needed)
2 = Flipped horizontally
3 = Rotated 180 deg
4 = Flipped vertically
5 = Rotated 90 deg CCW + flipped horizontally
6 = Rotated 90 deg CW
7 = Rotated 90 deg CW + flipped horizontally
8 = Rotated 90 deg CCW
```

- Uses `image` package to decode, apply `bakeOrientation()`, and re-encode as PNG
- Normalized images saved to `<appSupport>/normalized/` with UUID filenames
- Cleanup of old normalized images after 7 days
- Also provides in-memory normalization via `normalizeBytes()` (used by ImageToPdfService)

### Image Validation

`ImageValidationService` performs all checks in one call:

| Check | Condition | Error Key |
|-------|-----------|-----------|
| File exists | `!file.exists()` | `fileNotFound` |
| Format | Extension not in allowed list | `unsupportedImageFormat` |
| File size | > 50MB | `imageTooBig` |
| Resolution | Width or height > 4096 (after EXIF) | `imageResolutionTooHigh` |

The service also normalizes EXIF orientation as part of validation, returning the normalized path in the result.

### Background Removal

The app can automatically detect and remove uniform backgrounds from images (e.g., white paper behind a signature).

#### Detection (Dart)

`BackgroundDetectionService` analyzes image perimeter:

```dart
class BackgroundDetectionService {
  static const int _samplesPerEdge = 20;
  static const double _maxColorVariance = 25.0;

  Future<BackgroundDetectionResult> analyzeImage(String imagePath) async {
    // 1. Sample pixels along all 4 edges (80 total)
    // 2. Calculate mean RGB color
    // 3. Calculate color variance (standard deviation)
    // 4. If variance <= 25 -> uniform background detected
  }
}
```

#### Removal (Native)

Background removal uses platform-specific ML APIs with color-based fallback:

```
┌─────────────────────────────────────────────────────────────────┐
│                    BackgroundRemovalService                      │
│                         (Dart layer)                             │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              MethodChannel                               │    │
│  │    'com.ivanvaganov.minipdfsign/background_removal'     │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┴───────────────────┐
          ▼                                       ▼
┌─────────────────────────┐           ┌─────────────────────────┐
│      iOS (Swift)        │           │    Android (Kotlin)     │
├─────────────────────────┤           ├─────────────────────────┤
│ iOS 17+:                │           │ API 24+:                │
│  VNGenerateForeground-  │           │  ML Kit Subject         │
│  InstanceMaskRequest    │           │  Segmentation API       │
│                         │           │                         │
│ Fallback:               │           │ Fallback:               │
│  Color-based removal    │           │  Color-based removal    │
└─────────────────────────┘           └─────────────────────────┘
```

#### ML-Based Removal

Both platforms use ML segmentation to separate foreground from background:

1. ML model generates **confidence mask** (0.0 - 1.0 per pixel)
2. **Threshold applied** at 50% confidence for sharp edges
3. Pixels above threshold -> fully opaque (alpha = 255)
4. Pixels below threshold -> fully transparent (alpha = 0)

#### Why Threshold Instead of Gradient?

ML segmentation masks have soft/feathered edges by design (for natural compositing). However, for stamps and signatures we need **crisp boundaries**:

| Approach | Edge Quality | Use Case |
|----------|--------------|----------|
| Gradient alpha (`confidence * 255`) | Soft/blurry | Photo compositing |
| Threshold (`confidence >= 0.5 ? 255 : 0`) | Sharp/crisp | Stamps, signatures |

#### User Flow

```
User adds image
       │
       ▼
BackgroundDetectionService.analyzeImage()
       │
       ├─ Has transparency? -> Skip (already processed)
       │
       ├─ Variance > 25? -> Skip (no uniform background)
       │
       └─ Uniform background detected
              │
              ▼
       Show dialog: "Remove Background?"
              │
              ├─ "Keep" -> Save original image
              │
              └─ "Remove" -> BackgroundRemovalService.removeBackground()
                                    │
                                    ▼
                            Save PNG with transparency
```

## Image-to-PDF Conversion

`ImageToPdfService` converts images to A4 PDFs:

### Conversion Flow

```
1. Receive image path(s)
   │
2. For each image:
   │   ├─ Read image bytes
   │   ├─ Normalize EXIF orientation via ImageNormalizationService.normalizeBytes()
   │   ├─ Add A4 page (595 x 842 points)
   │   ├─ Calculate scale to fit within margins (36pt = 0.5 inch)
   │   └─ Center and draw scaled image on page
   │
3. Save PDF to temp directory
   │
4. Return temp PDF path
```

### Page Layout

```
┌───────────────────────────┐
│         36pt margin        │
│   ┌───────────────────┐   │
│   │                   │   │
│   │   Image centered  │   │
│   │   and scaled to   │   │
│   │   fit A4 with     │   │
│   │   aspect ratio    │   │
│   │                   │   │
│   └───────────────────┘   │
│         36pt margin        │
└───────────────────────────┘
A4: 595 x 842 points (210 x 297 mm)
```

### Saving Converted PDFs

After conversion, users can save to the app Documents directory:
- Files are visible in iOS Files app under "On My iPhone > miniPDFSign"
- Duplicate filenames get numbered suffix: `photo (1).pdf`, `photo (2).pdf`

## Placement System

### Drag and Drop

```dart
// In ImageGridItem
LongPressDraggable<SidebarImage>(
  delay: Duration(milliseconds: 200),
  data: image,
  feedback: _buildDragFeedback(),
  onDragStarted: () {
    HapticFeedback.mediumImpact();
    onDragStarted?.call();  // Collapses sheet
  },
  child: _buildThumbnail(),
)

// In PdfDropTarget
DragTarget<SidebarImage>(
  onAcceptWithDetails: (details) {
    final position = _calculateDropPosition(details);
    ref.read(sessionPlacedImagesProvider(sessionId).notifier).addImage(
      sourceImageId: details.data.id,
      imagePath: details.data.filePath,
      pageIndex: position.pageIndex,
      position: position.offset,
      size: _calculateDefaultSize(details.data),
    );
    ref.read(sessionDocumentDirtyProvider(sessionId).notifier).markDirty();
  },
)
```

### Drop Position Calculation

```dart
Offset _calculateDropPosition(DragTargetDetails details) {
  // 1. Get drop point in viewport coordinates
  final localPosition = details.offset;

  // 2. Convert to document coordinates (accounting for scroll)
  final docPosition = localPosition + scrollOffset;

  // 3. Find which page contains this point
  final pageIndex = _findPageAtPosition(docPosition);

  // 4. Convert to page-local coordinates
  final pageOffset = docPosition - _getPageTopLeft(pageIndex);

  // 5. Convert from screen pixels to PDF points
  final pdfPoints = pageOffset / scale;

  return pdfPoints;
}
```

### Coordinate Systems

| System | Unit | Origin | Usage |
|--------|------|--------|-------|
| Screen | Logical pixels | Top-left of viewport | Touch events |
| Document | Logical pixels | Top-left of first page | Scroll position |
| Page | PDF points (1/72") | Top-left of page | PlacedImage position |

## PlacedImage Entity

```dart
class PlacedImage extends Equatable {
  final String id;              // UUID
  final String sourceImageId;   // Reference to SidebarImage
  final String imagePath;       // File path for rendering
  final int pageIndex;          // 0-based page number
  final Offset position;        // Top-left in PDF points
  final Size size;              // Width/height in PDF points
  final double rotation;        // Radians (0 to 2*pi)

  Rect get bounds => Rect.fromLTWH(
    position.dx, position.dy, size.width, size.height
  );

  Offset get center => Offset(
    position.dx + size.width / 2,
    position.dy + size.height / 2,
  );
}
```

## Transform Controls

### PlacedImageWidget Structure

```
┌──────────────────────────────────────────┐
│                    O <- Rotation handle   │
│                    │                     │
│ ┌──────────────────┴─────────────────┐   │
│ │ O──────────────O──────────────O    │   │  O = Corner handle
│ │ │                              │    │   │  O = Side handle
│ │ O              img             O    │   │
│ │ │           (image)            │    │   │
│ │ O──────────────O──────────────O    │   │
│ │        [120 x 80 mm]               │   │  <- Size label
│ └────────────────────────────────────┘   │
└──────────────────────────────────────────┘
```

### Handle Interactions

| Handle | Gesture | Behavior |
|--------|---------|----------|
| Image body | Drag | Move image |
| Corner | Drag | Proportional resize (keeps aspect ratio) |
| Side | Drag | Non-proportional resize (stretches) |
| Rotation | Drag | Rotate around center |
| Two fingers | Pinch | Scale with aspect ratio |
| Two fingers | Rotate | Free rotation with haptic at 90 deg |

### Rotation Mathematics

```dart
void _handleRotation(DragUpdateDetails details) {
  // 1. Get center of image in screen coordinates
  final center = _getScreenCenter();

  // 2. Calculate angle from center to previous touch point
  final prevAngle = atan2(
    _lastRotationPoint.dy - center.dy,
    _lastRotationPoint.dx - center.dx,
  );

  // 3. Calculate angle from center to current touch point
  final currentAngle = atan2(
    details.globalPosition.dy - center.dy,
    details.globalPosition.dx - center.dx,
  );

  // 4. Apply delta rotation
  final delta = currentAngle - prevAngle;
  final newRotation = (image.rotation + delta) % (2 * pi);

  ref.read(sessionPlacedImagesProvider(sessionId).notifier)
      .rotateImage(image.id, newRotation);
}
```

### Corner Resize (Proportional)

```dart
void _handleCornerDrag(DragUpdateDetails details, Corner corner) {
  // 1. Calculate delta in PDF points
  final delta = details.delta / scale;

  // 2. Account for rotation
  final rotatedDelta = _rotatePoint(delta, -image.rotation);

  // 3. Calculate new size maintaining aspect ratio
  final aspectRatio = image.size.width / image.size.height;
  final newWidth = max(minSize, image.size.width + rotatedDelta.dx);
  final newHeight = newWidth / aspectRatio;

  // 4. Adjust position based on which corner is dragged
  final newPosition = _adjustPositionForCorner(corner, newWidth, newHeight);

  ref.read(sessionPlacedImagesProvider(sessionId).notifier).transformImage(
    image.id,
    position: newPosition,
    size: Size(newWidth, newHeight),
  );
}
```

## Gesture Conflict Resolution

### Problem

ScrollView and PlacedImageWidget both want to handle drag gestures.

### Solution

PlacedImagesLayer is positioned **outside** the ScrollView in the widget tree:

```dart
Stack(
  children: [
    PdfPageList(...),        // Inside ScrollView
    PlacedImagesLayer(...),  // Outside ScrollView
  ],
)
```

Additionally, `ConditionalScaleGestureRecognizer` checks if touch is on an object:

```dart
class ConditionalScaleGestureRecognizer extends ScaleGestureRecognizer {
  bool Function()? shouldReject;

  @override
  void rejectGesture(int pointer) {
    if (shouldReject?.call() ?? false) {
      super.rejectGesture(pointer);
    }
  }
}
```

## Save System

### Save Flow

```
1. User initiates save (Cmd+S, Back button, Share)
   │
2. Check sessionFileSourceProvider
   │
   ├─ filesApp -> Can overwrite original
   │              └─ PdfSaveService.savePdf(originalPath, images, originalPath)
   │
   ├─ filePicker/recentFile -> Must use Share Sheet
   │                           └─ PdfShareService.sharePdf(originalPath, images)
   │
   └─ convertedImage -> Save to Documents + add to Recent Files
                        └─ ImageToPdfService.savePdfToDocuments(...)
```

### PdfSaveService

Uses Syncfusion PDF library to embed images:

```dart
Future<Either<Failure, String>> savePdf({
  required String originalPath,
  required List<PlacedImage> placedImages,
  required String outputPath,
}) async {
  // 1. Load original PDF
  final bytes = await File(originalPath).readAsBytes();
  final document = PdfDocument(inputBytes: bytes);

  // 2. Group images by page
  final imagesByPage = groupBy(placedImages, (img) => img.pageIndex);

  // 3. Embed each image
  for (final entry in imagesByPage.entries) {
    final page = document.pages[entry.key];
    final graphics = page.graphics;

    for (final image in entry.value) {
      // Load image
      final imageBytes = await File(image.imagePath).readAsBytes();
      final pdfImage = PdfBitmap(imageBytes);

      // Apply rotation transform
      graphics.save();
      graphics.translateTransform(image.center.dx, image.center.dy);
      graphics.rotateTransform(image.rotation * 180 / pi);
      graphics.translateTransform(-image.size.width / 2, -image.size.height / 2);

      // Draw image
      graphics.drawImage(
        pdfImage,
        Rect.fromLTWH(0, 0, image.size.width, image.size.height),
      );

      graphics.restore();
    }
  }

  // 4. Save
  final outputBytes = await document.save();
  await File(outputPath).writeAsBytes(outputBytes);
  document.dispose();

  return Right(outputPath);
}
```

### OriginalPdfStorage

Preserves original PDF bytes for clean saves:

```dart
class OriginalPdfStorage {
  Uint8List? _inMemoryBytes;  // For files <= 50MB
  String? _tempFilePath;       // For files > 50MB

  Future<bool> store(String sourcePath) async {
    final file = File(sourcePath);
    final size = await file.length();

    if (size <= _memoryThreshold) {
      _inMemoryBytes = await file.readAsBytes();
    } else {
      _tempFilePath = await _copyToTemp(sourcePath);
    }
    return true;
  }

  Future<Uint8List> getBytes() async {
    if (_inMemoryBytes != null) return _inMemoryBytes!;
    return File(_tempFilePath!).readAsBytes();
  }
}
```

## Dirty State Tracking

`sessionDocumentDirtyProvider` tracks unsaved changes:

```dart
// Mark dirty on any edit
ref.read(sessionDocumentDirtyProvider(sessionId).notifier).markDirty();

// Check before navigation
final isDirty = ref.read(sessionDocumentDirtyProvider(sessionId));
if (isDirty) {
  final result = await showUnsavedChangesDialog();
  // Handle save/discard/cancel
}

// Clear after save
ref.read(sessionDocumentDirtyProvider(sessionId).notifier).markClean();
```

## Selection System

`sessionEditorSelectionProvider` tracks selected image:

```dart
// Select on tap
ref.read(sessionEditorSelectionProvider(sessionId).notifier).select(image.id);

// Clear on tap outside
ref.read(sessionEditorSelectionProvider(sessionId).notifier).clear();

// Toggle selection
ref.read(sessionEditorSelectionProvider(sessionId).notifier).toggle(image.id);

// Delete selected
final selectedId = ref.read(sessionEditorSelectionProvider(sessionId));
if (selectedId != null) {
  ref.read(sessionPlacedImagesProvider(sessionId).notifier).removeImage(selectedId);
  ref.read(sessionEditorSelectionProvider(sessionId).notifier).clear();
}
```

## Copy/Paste

```dart
// Copy (Cmd+C)
void _copySelectedImage() {
  final selectedId = ref.read(sessionEditorSelectionProvider(sessionId));
  final images = ref.read(sessionPlacedImagesProvider(sessionId));
  final selected = images.firstWhereOrNull((img) => img.id == selectedId);
  if (selected != null) {
    _clipboard = selected;
    HapticFeedback.lightImpact();
  }
}

// Paste (Cmd+V)
void _pasteImage() {
  if (_clipboard == null) return;

  ref.read(sessionPlacedImagesProvider(sessionId).notifier).duplicateImage(
    _clipboard!.id,
    offset: const Offset(20, 20),
  );
  ref.read(sessionDocumentDirtyProvider(sessionId).notifier).markDirty();
}
```

## Related Documentation

- [ARCHITECTURE.md](./ARCHITECTURE.md) — High-level architecture
- [STATE_MANAGEMENT.md](./STATE_MANAGEMENT.md) — Riverpod provider details
- [adr/004-background-removal.md](./adr/004-background-removal.md) — Background removal decision
