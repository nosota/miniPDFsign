# PDF Editing System

This document describes the PDF editing architecture - how images are placed, manipulated, and saved.

## Overview

miniPDFSign allows users to place images (signatures, stamps) on PDF documents. The editing system consists of:

1. **Image Library** - Collection of reusable images
2. **Placement System** - Drag-and-drop onto PDF pages
3. **Transform Controls** - Move, resize, rotate placed images
4. **Save System** - Embed images into PDF

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
│  │  │ 📷 │ │ 📷 │ │ 📷 │ │ ➕ │  (draggable)          │    │
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
  late int width;           // Original pixels
  late int height;
  late int fileSize;
}
```

### Adding Images

1. User taps "+" button in ImageLibrarySheet
2. ImagePickerService opens file picker or photo gallery
3. ImageValidationService validates:
   - File exists
   - Supported format (PNG, JPG, GIF, WEBP, BMP, HEIC)
   - File size ≤ 50MB
   - Resolution ≤ 4096×4096
4. ImageStorageService copies to app storage with UUID filename
5. SidebarImageRepository adds to Isar database
6. Stream updates UI automatically

### Validation Errors

| Error Key | Condition |
|-----------|-----------|
| `fileNotFound` | File doesn't exist |
| `unsupportedImageFormat` | Invalid extension |
| `imageTooBig` | File > 50MB |
| `imageResolutionTooHigh` | Width or height > 4096 |

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
    ref.read(placedImagesProvider.notifier).addImage(
      sourceImageId: details.data.id,
      imagePath: details.data.filePath,
      pageIndex: position.pageIndex,
      position: position.offset,
      size: _calculateDefaultSize(details.data),
    );
    ref.read(documentDirtyProvider.notifier).markDirty();
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
  final double rotation;        // Radians (0 to 2π)

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
│                    ◯ ← Rotation handle   │
│                    │                     │
│ ┌──────────────────┴─────────────────┐   │
│ │ ◯──────────────◯──────────────◯    │   │  ◯ = Corner handle
│ │ │                              │    │   │  ◯ = Side handle
│ │ ◯              📷              ◯    │   │
│ │ │           (image)            │    │   │
│ │ ◯──────────────◯──────────────◯    │   │
│ │        [120 × 80 mm]               │   │  ← Size label
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
| Two fingers | Rotate | Free rotation with haptic at 90° |

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

  ref.read(placedImagesProvider.notifier).rotateImage(image.id, newRotation);
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

  ref.read(placedImagesProvider.notifier).transformImage(
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
2. Check fileSourceProvider
   │
   ├─ filesApp → Can overwrite original
   │              └─ PdfSaveService.savePdf(originalPath, images, originalPath)
   │
   └─ filePicker/recentFile → Must use Share Sheet
                              └─ PdfShareService.sharePdf(originalPath, images)
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
  Uint8List? _inMemoryBytes;  // For files ≤ 50MB
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

`documentDirtyProvider` tracks unsaved changes:

```dart
// Mark dirty on any edit
ref.read(documentDirtyProvider.notifier).markDirty();

// Check before navigation
final isDirty = ref.read(documentDirtyProvider);
if (isDirty) {
  final result = await showUnsavedChangesDialog();
  // Handle save/discard/cancel
}

// Clear after save
ref.read(documentDirtyProvider.notifier).markClean();
```

## Selection System

`editorSelectionProvider` tracks selected image:

```dart
// Select on tap
ref.read(editorSelectionProvider.notifier).select(image.id);

// Clear on tap outside
ref.read(editorSelectionProvider.notifier).clear();

// Delete selected
final selectedId = ref.read(editorSelectionProvider);
if (selectedId != null) {
  ref.read(placedImagesProvider.notifier).removeImage(selectedId);
  ref.read(editorSelectionProvider.notifier).clear();
}
```

## Copy/Paste

```dart
// Copy (Cmd+C)
void _copySelectedImage() {
  final selectedId = ref.read(editorSelectionProvider);
  final images = ref.read(placedImagesProvider);
  final selected = images.firstWhereOrNull((img) => img.id == selectedId);
  if (selected != null) {
    _clipboard = selected;
    HapticFeedback.lightImpact();
  }
}

// Paste (Cmd+V)
void _pasteImage() {
  if (_clipboard == null) return;

  ref.read(placedImagesProvider.notifier).duplicateImage(
    _clipboard!.id,
    const Offset(20, 20),  // Offset from original
  );
  ref.read(documentDirtyProvider.notifier).markDirty();
}
```
