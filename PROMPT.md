# Object Rotation Feature — Implementation Guide for Claude Code

This document describes in detail how to implement object rotation (and related transform controls) for a desktop application. Based on a production Flutter implementation.

---

## 1. Feature Overview

The feature allows users to select objects placed on a canvas and transform them:
- **Move** — drag the object body
- **Resize (proportional)** — drag corner handles
- **Resize (non-proportional)** — drag side handles
- **Rotate** — drag the rotation handle at the top

All transforms preserve the object's center position (except move) and support arbitrary rotation angles.

---

## 2. Architecture Layers

```
┌─────────────────────────────────────────────────────────────────┐
│                       PRESENTATION LAYER                         │
├─────────────────────────────────────────────────────────────────┤
│  PlacedImagesLayer          │  Renders objects outside ScrollView│
│  PlacedImageWidget          │  Individual object with handles    │
│  _CornerHandle              │  Corner resize handles             │
│  _SideHandle                │  Side resize handles               │
│  _RotationHandle            │  Rotation handle with stem         │
│  SizeLabel                  │  Dimension display (e.g., 5×3 cm)  │
├─────────────────────────────────────────────────────────────────┤
│                       STATE MANAGEMENT                           │
├─────────────────────────────────────────────────────────────────┤
│  PlacedImagesProvider       │  List of placed objects            │
│  EditorSelectionProvider    │  Currently selected object ID      │
│  PointerOnObjectProvider    │  Tracks which pointers touch which │
│                             │  objects (for gesture routing)     │
├─────────────────────────────────────────────────────────────────┤
│                       DOMAIN LAYER                               │
├─────────────────────────────────────────────────────────────────┤
│  PlacedImage                │  Entity with position, size,       │
│                             │  rotation (radians)                │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Entity: PlacedImage

```dart
class PlacedImage extends Equatable {
  final String id;              // Unique identifier (UUID)
  final String sourceImageId;   // Reference to source asset
  final String imagePath;       // File path for rendering
  final int pageIndex;          // Which page/canvas (0-based)
  final Offset position;        // Top-left corner in canvas units
  final Size size;              // Width/height in canvas units
  final double rotation;        // Angle in RADIANS (0 to 2π)

  // Computed properties
  Rect get bounds => Rect.fromLTWH(
    position.dx, position.dy, size.width, size.height
  );

  Offset get center => Offset(
    position.dx + size.width / 2,
    position.dy + size.height / 2,
  );

  PlacedImage copyWith({...});
}
```

**Key points:**
- Rotation is stored in **radians**, not degrees
- Position is the **top-left corner** before rotation
- Center is computed from position + size/2

---

## 4. State Management

### PlacedImagesProvider

```dart
class PlacedImages extends _$PlacedImages {
  @override
  List<PlacedImage> build() => [];

  void addImage({...});
  void removeImage(String id);
  void moveImage(String id, Offset newPosition);
  void resizeImage(String id, Size newSize);
  void rotateImage(String id, double newRotation);

  // Combined transform for smooth manipulation
  void transformImage(String id, {
    Offset? position,
    Size? size,
    double? rotation,
  });
}
```

### EditorSelectionProvider

Simple string state holding the selected object's ID (or null).

### PointerOnObjectProvider

Maps `pointer ID → object ID` for gesture routing:

```dart
class PointerOnObjectNotifier extends StateNotifier<Map<int, String>> {
  void pointerDown(int pointerId, String objectId);
  void pointerUp(int pointerId);
  String? allPointersOnSameObject(int pointerCount);
}
```

---

## 5. Visual Design Constants

```dart
class SelectionHandleConstants {
  // === HANDLE SIZES ===

  // Corner handles (for proportional resize)
  static const double cornerHandleSize = 20.0;    // Visual diameter
  static const double cornerHitSize = 48.0;       // Touch target

  // Side handles (for stretch resize)
  static const double sideHandleSize = 16.0;      // Visual diameter
  static const double sideHitSize = 48.0;         // Touch target

  // Rotation handle
  static const double rotationHandleSize = 32.0;  // Visual diameter
  static const double rotationHandleHitSize = 48.0;
  static const double rotationHandleStemLength = 24.0;  // Line from edge to handle
  static const double rotationStemWidth = 2.0;    // Stem line thickness

  // === CONSTRAINTS ===
  static const double minObjectSize = 40.0;       // Minimum width/height

  // === COLORS ===
  static const Color handleActiveColor = Color(0xFF2196F3);  // Bright blue
  static const Color handleBorderColor = Colors.white;
  static const Color selectionBorderColor = Color(0xFF2196F3);

  // === OPACITY ===
  static const double inactiveOpacity = 0.4;      // Non-hovered handles

  // === BORDER WIDTHS ===
  static const double handleBorderWidth = 2.0;
  static const double selectionBorderWidth = 2.0;
}
```

---

## 6. Widget Structure

### Selection UI Layout

```
                    ○ ← Rotation handle (circle with refresh icon)
                    │
                    │ ← Stem line (24px)
                    │
    ○───────────────●───────────────○
    │                               │
    ●         [IMAGE CONTENT]       ●  ← Side handles (stretch)
    │                               │
    ○───────────────●───────────────○

    ○ = Corner handles (proportional resize)
    ● = Side handles (non-proportional resize)
```

### Handle Visual States

| State | Fill Color | Border Color |
|-------|------------|--------------|
| Default | `handleActiveColor` @ 40% | `white` @ 40% |
| Hovered | `handleActiveColor` @ 100% | `white` @ 100% |
| Active (dragging) | `handleActiveColor` @ 100% | `white` @ 100% |

### Selection Border

- Color: `#2196F3` (blue) @ 40% opacity
- Width: 2px
- Applied to the image bounds (rotates with image)

---

## 7. Coordinate Systems

### Three Coordinate Spaces

1. **Screen coordinates** — pixels on screen
2. **Canvas coordinates** — units in your document (PDF points, pixels, etc.)
3. **Local coordinates** — relative to object center, axis-aligned

### Key Transformations

```dart
/// Rotates a point around origin (0,0)
Offset _rotatePoint(Offset point, double rotation) {
  final cosR = math.cos(rotation);
  final sinR = math.sin(rotation);
  return Offset(
    point.dx * cosR - point.dy * sinR,
    point.dx * sinR + point.dy * cosR,
  );
}

/// Transforms screen delta to object's local coordinates
/// (accounting for object's current rotation)
Offset _transformToLocal(Offset screenDelta, double rotation) {
  // Inverse rotation: multiply by -rotation
  final cosR = math.cos(-rotation);
  final sinR = math.sin(-rotation);
  return Offset(
    screenDelta.dx * cosR - screenDelta.dy * sinR,
    screenDelta.dx * sinR + screenDelta.dy * cosR,
  );
}
```

---

## 8. Computing Handle Positions

Handles are positioned **outside** the Transform.rotate, in screen coordinates:

```dart
Map<String, Offset> _computeCornerPositions(
  Offset center,           // Center in screen coords
  double scaledWidth,      // Scaled width in pixels
  double scaledHeight,     // Scaled height in pixels
  double rotation,         // Current rotation in radians
) {
  final halfW = scaledWidth / 2;
  final halfH = scaledHeight / 2;

  // Local positions (before rotation)
  final localCorners = {
    'topLeft': Offset(-halfW, -halfH),
    'topRight': Offset(halfW, -halfH),
    'bottomLeft': Offset(-halfW, halfH),
    'bottomRight': Offset(halfW, halfH),
  };

  // Rotate each corner and offset from center
  return localCorners.map((key, local) {
    final rotated = _rotatePoint(local, rotation);
    return MapEntry(key, center + rotated);
  });
}

Map<String, Offset> _computeSidePositions(...) {
  // Same pattern, but for midpoints of edges
  final localSides = {
    'top': Offset(0, -halfH),
    'bottom': Offset(0, halfH),
    'left': Offset(-halfW, 0),
    'right': Offset(halfW, 0),
  };
  // ... rotate and offset
}
```

---

## 9. Rotation Handle Implementation

### Position Calculation

```dart
// Top edge center in local coords (before rotation)
final halfH = scaledHeight / 2;
final topEdgeLocal = Offset(0, -halfH);

// Rotate to get screen position
final topEdgeScreen = centerLocal + _rotatePoint(topEdgeLocal, rotation);

// Direction "up" from top edge (outward, perpendicular)
final upDirection = _rotatePoint(const Offset(0, -1), rotation);

// Handle center position
final handleCenter = topEdgeScreen + upDirection * (stemLength + handleSize / 2);
```

### Stem Line

Draw a line from `topEdgeScreen` to `handleCenter`:

```dart
class _StemPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);
  }
}
```

---

## 10. Rotation Gesture Mathematics

### Starting Rotation

```dart
void _handleRotateDragStart() {
  _rotateStartRotation = widget.image.rotation;  // Save current angle
  _rotateStartAngle = null;  // Will be set on first update
}
```

### During Rotation

```dart
void _handleRotateDrag(Offset globalPosition) {
  // Convert global position to local widget coordinates
  final renderBox = context.findRenderObject() as RenderBox;
  final localPos = renderBox.globalToLocal(globalPosition);

  // Calculate center of widget (where object center is)
  final centerLocal = Offset(widgetWidth / 2, widgetHeight / 2);

  // Current angle from center to pointer
  final currentAngle = (localPos - centerLocal).direction;

  // Save start angle on first update
  if (_rotateStartAngle == null) {
    _rotateStartAngle = currentAngle;
    return;
  }

  // Calculate delta with ±180° wrapping
  var angleDelta = currentAngle - _rotateStartAngle!;
  while (angleDelta > math.pi) angleDelta -= 2 * math.pi;
  while (angleDelta < -math.pi) angleDelta += 2 * math.pi;

  // Apply rotation
  final newRotation = _rotateStartRotation! + angleDelta;
  provider.rotateImage(image.id, newRotation);
}
```

### Key Math: `Offset.direction`

Returns angle in radians from positive X-axis, range [-π, π]:
- Right (positive X): 0
- Down (positive Y): π/2
- Left: ±π
- Up (negative Y): -π/2

---

## 11. Two-Finger Rotation (Optional)

For touch devices, support pinch-to-rotate:

```dart
void _handleScaleStart(ScaleStartDetails details) {
  if (details.pointerCount >= 2) {
    _twoFingerStartRotation = widget.image.rotation;
    _lastHapticQuadrant = _getQuadrant(widget.image.rotation);
  }
}

void _handleScaleUpdate(ScaleUpdateDetails details) {
  if (details.pointerCount >= 2) {
    final newRotation = _twoFingerStartRotation! + details.rotation;

    // Haptic feedback at 0°, 90°, 180°, 270°
    final newQuadrant = _getQuadrant(newRotation);
    if (newQuadrant != _lastHapticQuadrant) {
      HapticFeedback.lightImpact();
      _lastHapticQuadrant = newQuadrant;
    }

    provider.rotateImage(image.id, newRotation);
  }
}

int _getQuadrant(double rotation) {
  var angle = rotation % (2 * math.pi);
  if (angle < 0) angle += 2 * math.pi;

  if (angle < math.pi/4 || angle >= 7*math.pi/4) return 0;  // ~0°
  if (angle < 3*math.pi/4) return 1;  // ~90°
  if (angle < 5*math.pi/4) return 2;  // ~180°
  return 3;  // ~270°
}
```

---

## 12. Proportional Corner Resize

Corner handles maintain aspect ratio:

```dart
void _handleProportionalResize(String corner, Offset localDelta) {
  final oldWidth = image.size.width;
  final oldHeight = image.size.height;
  final oldCenter = image.center;

  // Calculate target width based on which corner is dragged
  double targetWidth;
  switch (corner) {
    case 'topLeft':
    case 'bottomLeft':
      targetWidth = oldWidth - localDelta.dx;  // Dragging left shrinks
    case 'topRight':
    case 'bottomRight':
      targetWidth = oldWidth + localDelta.dx;  // Dragging right grows
  }

  // Scale proportionally
  var scale = targetWidth / oldWidth;
  var newWidth = oldWidth * scale;
  var newHeight = oldHeight * scale;

  // Enforce minimum size
  if (newWidth < minSize || newHeight < minSize) {
    final minScale = max(minSize / oldWidth, minSize / oldHeight);
    scale = minScale;
    newWidth = oldWidth * scale;
    newHeight = oldHeight * scale;
  }

  // Shift center to keep opposite corner fixed
  final widthDelta = newWidth - oldWidth;
  final heightDelta = newHeight - oldHeight;

  Offset localCenterShift;
  switch (corner) {
    case 'topLeft':
      localCenterShift = Offset(-widthDelta/2, -heightDelta/2);
    case 'topRight':
      localCenterShift = Offset(widthDelta/2, -heightDelta/2);
    case 'bottomLeft':
      localCenterShift = Offset(-widthDelta/2, heightDelta/2);
    case 'bottomRight':
      localCenterShift = Offset(widthDelta/2, heightDelta/2);
  }

  // Transform shift back to canvas coordinates (accounting for rotation)
  final canvasCenterShift = _rotatePoint(localCenterShift, image.rotation);
  final newCenter = oldCenter + canvasCenterShift;
  final newPosition = Offset(
    newCenter.dx - newWidth/2,
    newCenter.dy - newHeight/2,
  );

  provider.transformImage(image.id, position: newPosition, size: Size(newWidth, newHeight));
}
```

---

## 13. Non-Proportional Side Resize

Side handles stretch only one axis:

```dart
void _handleSideDrag(String side, Offset delta) {
  final localDelta = _transformToLocal(delta / scale, image.rotation);

  var newWidth = image.size.width;
  var newHeight = image.size.height;
  var newPosition = image.position;

  switch (side) {
    case 'top':
      final newH = (image.size.height - localDelta.dy).clamp(minSize, infinity);
      newPosition = Offset(newPosition.dx, newPosition.dy + (image.size.height - newH));
      newHeight = newH;
    case 'bottom':
      newHeight = (image.size.height + localDelta.dy).clamp(minSize, infinity);
    case 'left':
      final newW = (image.size.width - localDelta.dx).clamp(minSize, infinity);
      newPosition = Offset(newPosition.dx + (image.size.width - newW), newPosition.dy);
      newWidth = newW;
    case 'right':
      newWidth = (image.size.width + localDelta.dx).clamp(minSize, infinity);
  }

  provider.transformImage(image.id, position: newPosition, size: Size(newWidth, newHeight));
}
```

---

## 14. Cursor Management

### Corner Handle Cursors

Cursor changes based on rotation to match visual diagonal:

```dart
MouseCursor _getCornerCursor(String corner, double rotation) {
  // Base angles for each corner (degrees, unrotated)
  const baseAngles = {
    'topLeft': 225.0,      // ↖
    'topRight': 315.0,     // ↗
    'bottomRight': 45.0,   // ↘
    'bottomLeft': 135.0,   // ↙
  };

  // Add rotation (convert to degrees)
  var angle = (baseAngles[corner]! + rotation * 180 / math.pi) % 360;
  if (angle < 0) angle += 360;

  // Map to 8 cursor directions (45° each)
  if (angle >= 337.5 || angle < 22.5) return SystemMouseCursors.resizeLeftRight;
  if (angle >= 22.5 && angle < 67.5) return SystemMouseCursors.resizeUpLeftDownRight;
  if (angle >= 67.5 && angle < 112.5) return SystemMouseCursors.resizeUpDown;
  if (angle >= 112.5 && angle < 157.5) return SystemMouseCursors.resizeUpRightDownLeft;
  if (angle >= 157.5 && angle < 202.5) return SystemMouseCursors.resizeLeftRight;
  if (angle >= 202.5 && angle < 247.5) return SystemMouseCursors.resizeUpLeftDownRight;
  if (angle >= 247.5 && angle < 292.5) return SystemMouseCursors.resizeUpDown;
  return SystemMouseCursors.resizeUpRightDownLeft;
}
```

### Side Handle Cursors

```dart
MouseCursor _getSideCursor(String side, double rotation) {
  const baseAngles = {
    'top': 270.0,
    'bottom': 90.0,
    'left': 180.0,
    'right': 0.0,
  };

  var angle = (baseAngles[side]! + rotation * 180 / pi) % 360;
  if (angle < 0) angle += 360;

  final isVertical = (angle >= 45 && angle < 135) || (angle >= 225 && angle < 315);
  return isVertical ? SystemMouseCursors.resizeUpDown : SystemMouseCursors.resizeLeftRight;
}
```

### Rotation Handle Cursor

- Default: `SystemMouseCursors.grab`
- Dragging: `SystemMouseCursors.grabbing`

---

## 15. Size Label Positioning

The size label follows the **visually bottom edge** (maximum Y in screen coords):

```dart
({String edge, Offset center, double labelRotation}) _findBottomEdge() {
  // Edge centers in local coords
  final localCenters = {
    'top': Offset(0, -halfH),
    'bottom': Offset(0, halfH),
    'left': Offset(-halfW, 0),
    'right': Offset(halfW, 0),
  };

  // Find edge with maximum Y in screen coords
  String bottomEdge = 'bottom';
  double maxY = double.negativeInfinity;

  for (final entry in localCenters.entries) {
    final rotated = _rotatePoint(entry.value, rotation);
    final screenPos = widgetCenter + rotated;
    if (screenPos.dy > maxY) {
      maxY = screenPos.dy;
      bottomEdge = entry.key;
    }
  }

  // Calculate label rotation to stay readable (not upside down)
  double labelRotation;
  switch (bottomEdge) {
    case 'top': labelRotation = rotation + pi;
    case 'bottom': labelRotation = rotation;
    case 'left': labelRotation = rotation - pi/2;
    case 'right': labelRotation = rotation + pi/2;
  }

  // Normalize to [-π/2, π/2] for readability
  while (labelRotation > pi/2) labelRotation -= pi;
  while (labelRotation < -pi/2) labelRotation += pi;

  return (edge: bottomEdge, center: screenCenter, labelRotation: labelRotation);
}
```

---

## 16. Edge Cases

### 1. Angle Wraparound at ±180°

When rotating through ±180°, ensure smooth transition:

```dart
var angleDelta = currentAngle - startAngle;
while (angleDelta > math.pi) angleDelta -= 2 * math.pi;
while (angleDelta < -math.pi) angleDelta += 2 * math.pi;
```

### 2. Minimum Size Constraint

Always enforce minimum size during resize:

```dart
if (newWidth < minSize || newHeight < minSize) {
  // Clamp to minimum while maintaining aspect ratio (for proportional)
  // or clamp individual dimension (for non-proportional)
}
```

### 3. Gesture Conflicts with Scroll

Place the object layer **outside** the ScrollView in the widget tree:

```dart
Stack(
  children: [
    ScrollView(...),           // Scrollable content
    PlacedImagesLayer(...),    // Objects rendered on top
  ],
)
```

### 4. Multiple Pointers

Track which pointers are on which objects to route gestures correctly:
- All pointers on same object → handle multi-touch on object
- Some pointers on object, some outside → ignore or route to canvas

### 5. Object Outside Viewport

Don't render objects that are far outside the visible area:

```dart
bool _isImageVisible(PlacedImage image) {
  // Calculate screen bounds with padding for handles
  const padding = 100.0;  // Extra space for handles/rotation
  return imageBottom + padding >= 0 &&
         imageTop - padding <= viewportHeight;
}
```

---

## 17. Saving Rotation to PDF

When embedding rotated images into PDF, use graphics state transforms:

```dart
// Save state
graphics.save();

// Move origin to image center
graphics.translateTransform(centerX, centerY);

// Rotate (PDF uses degrees)
graphics.rotateTransform(radians * 180 / pi);

// Move origin back
graphics.translateTransform(-centerX, -centerY);

// Draw image at original position
graphics.drawImage(pdfImage, Rect.fromLTWH(x, y, width, height));

// Restore state
graphics.restore();
```

---

## 18. Implementation Checklist

- [ ] **Entity**: Add `rotation` field (double, radians, default 0)
- [ ] **Provider**: Add `rotateImage()` and `transformImage()` methods
- [ ] **Widget**: Create `PlacedImageWidget` with selection UI
- [ ] **Handles**: Implement corner, side, and rotation handles
- [ ] **Math**: Implement `_rotatePoint()` and `_transformToLocal()`
- [ ] **Cursors**: Implement rotation-aware cursor selection
- [ ] **Gestures**: Handle rotation drag with angle wraparound
- [ ] **Constraints**: Enforce minimum size
- [ ] **Visibility**: Skip rendering off-screen objects
- [ ] **Pointer tracking**: Route gestures correctly
- [ ] **Size label**: Position at visual bottom edge
- [ ] **Serialization**: Save/load rotation value
- [ ] **Export**: Apply rotation when saving to final format

---

## 19. Testing Scenarios

1. **Rotate 360°** — should return to original orientation
2. **Rotate past ±180°** — should be smooth, not jumpy
3. **Resize while rotated** — opposite corner should stay fixed
4. **Minimum size** — should not shrink below limit
5. **Multiple objects** — selection should work independently
6. **Zoom in/out** — handles should scale appropriately
7. **Cursor hover** — should match diagonal direction
8. **Two-finger rotate** — should give haptic at 0°, 90°, 180°, 270°

---

## 20. Code Files Reference

| File | Purpose |
|------|---------|
| `placed_image.dart` | Entity definition |
| `placed_images_provider.dart` | State management |
| `placed_image_overlay.dart` | Main widget with handles |
| `placed_images_layer.dart` | Container outside ScrollView |
| `size_label.dart` | Dimension display widget |
| `pointer_on_object_provider.dart` | Pointer-to-object mapping |
| `pdf_save_service.dart` | Saving with rotation |

---

*This document is intended for use with Claude Code or similar AI coding assistants to implement an equivalent feature in any desktop framework (Flutter, Electron, Qt, etc.).*
