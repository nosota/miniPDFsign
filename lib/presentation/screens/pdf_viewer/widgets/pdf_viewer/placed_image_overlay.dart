import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/placed_image.dart';
import 'package:minipdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/pointer_on_object_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/size_label.dart';

/// Selection handle constants.
class SelectionHandleConstants {
  // Визуальные размеры handles
  static const double cornerHandleSize = 20.0; // 20px circle
  static const double sideHandleSize = 16.0; // 16px circle

  // Hit-области (больше визуальных для удобства клика)
  static const double cornerHitSize = 48.0; // 48x48 touch area
  static const double sideHitSize = 48.0; // 48x48 touch area

  // Rotation handle (сверху объекта на ножке)
  static const double rotationHandleSize = 32.0; // 32px circle
  static const double rotationHandleHitSize = 48.0; // Touch area
  static const double rotationHandleStemLength = 24.0; // Длина ножки от края объекта
  static const double rotationStemWidth = 2.0; // Ширина линии ножки

  // Полная высота маркера вращения (для расчёта padding)
  static double get rotationHandleTotalHeight =>
      rotationHandleStemLength + rotationHandleSize / 2;

  // Ограничения
  static const double minObjectSize = 40.0;

  // Визуальные стили
  static const double handleBorderWidth = 2.0;

  // Цвета для маркеров (синий с белой обводкой)
  static const Color handleActiveColor = Color(0xFF2196F3); // Яркий синий (активный)
  static const Color handleBorderColor = Colors.white; // Белая обводка

  // Прозрачность для неактивных элементов
  static const double inactiveOpacity = 0.4;

  // Цвет рамки выделения
  static const Color selectionBorderColor = Color(0xFF2196F3);
  static const double selectionBorderWidth = 2.0;
}

/// Overlay widget that renders placed images on a single PDF page.
///
/// This is rendered for each page that has placed images.
class PlacedImageOverlay extends ConsumerWidget {
  const PlacedImageOverlay({
    required this.pageIndex,
    required this.scale,
    super.key,
  });

  final int pageIndex;
  final double scale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allImages = ref.watch(placedImagesProvider);
    final selectedId = ref.watch(editorSelectionProvider);

    // Filter images for this page
    final pageImages =
        allImages.where((img) => img.pageIndex == pageIndex).toList();

    if (pageImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (final image in pageImages)
          PlacedImageWidget(
            key: ValueKey(image.id),
            image: image,
            scale: scale,
            isSelected: image.id == selectedId,
          ),
      ],
    );
  }
}

/// Individual placed image with selection handles.
///
/// Can be positioned in two modes:
/// 1. Relative to page (default): Uses [image.position] to calculate screen position.
///    Used by [PlacedImageOverlay] when rendered inside a page.
/// 2. Absolute screen position: When [screenOffset] is provided, uses it directly.
///    Used by [PlacedImagesLayer] when rendered outside the ScrollView.
class PlacedImageWidget extends ConsumerStatefulWidget {
  const PlacedImageWidget({
    required this.image,
    required this.scale,
    required this.isSelected,
    this.screenOffset,
    super.key,
  });

  final PlacedImage image;
  final double scale;
  final bool isSelected;

  /// Optional screen offset for absolute positioning.
  ///
  /// When provided, this is the top-left corner of the image in screen coordinates.
  /// When null, position is calculated from [image.position] relative to the page.
  final Offset? screenOffset;

  @override
  ConsumerState<PlacedImageWidget> createState() => _PlacedImageWidgetState();
}

class _PlacedImageWidgetState extends ConsumerState<PlacedImageWidget> {
  bool _isDragging = false;
  bool _isRotating = false;

  // Rotation state (saved at drag start for smooth rotation)
  double? _rotateStartAngle;
  double? _rotateStartRotation;

  // Scale state (saved at pinch start for smooth scaling)
  double? _scaleStartWidth;

  // Two-finger rotation state
  double? _twoFingerStartRotation;
  int? _lastHapticQuadrant;

  // Track active handle for visual feedback
  String? _activeHandle; // 'corner:topLeft', 'side:top', 'rotate:topLeft', 'body', etc.

  // Track pointers on this object for gesture routing
  final Set<int> _activePointers = {};

  @override
  void dispose() {
    // Clean up any active pointers from the provider to prevent stale state
    if (_activePointers.isNotEmpty) {
      final notifier = ref.read(pointerOnObjectProvider.notifier);
      for (final pointerId in _activePointers) {
        notifier.pointerUp(pointerId);
      }
      _activePointers.clear();
    }
    super.dispose();
  }

  /// Rotates a point around origin (0,0).
  Offset _rotatePoint(Offset point, double rotation) {
    final cosR = math.cos(rotation);
    final sinR = math.sin(rotation);
    return Offset(
      point.dx * cosR - point.dy * sinR,
      point.dx * sinR + point.dy * cosR,
    );
  }

  /// Transforms screen delta to object's local coordinates (accounting for rotation).
  Offset _transformToLocal(Offset screenDelta, double rotation) {
    final cosR = math.cos(-rotation);
    final sinR = math.sin(-rotation);
    return Offset(
      screenDelta.dx * cosR - screenDelta.dy * sinR,
      screenDelta.dx * sinR + screenDelta.dy * cosR,
    );
  }

  /// Computes corner positions in screen coordinates (relative to widget origin).
  Map<String, Offset> _computeCornerPositions(
    Offset center,
    double scaledWidth,
    double scaledHeight,
    double rotation,
  ) {
    final halfW = scaledWidth / 2;
    final halfH = scaledHeight / 2;

    final localCorners = {
      'topLeft': Offset(-halfW, -halfH),
      'topRight': Offset(halfW, -halfH),
      'bottomLeft': Offset(-halfW, halfH),
      'bottomRight': Offset(halfW, halfH),
    };

    return localCorners.map((key, local) {
      final rotated = _rotatePoint(local, rotation);
      return MapEntry(key, center + rotated);
    });
  }

  /// Computes side center positions in screen coordinates.
  Map<String, Offset> _computeSidePositions(
    Offset center,
    double scaledWidth,
    double scaledHeight,
    double rotation,
  ) {
    final halfW = scaledWidth / 2;
    final halfH = scaledHeight / 2;

    final localSides = {
      'top': Offset(0, -halfH),
      'bottom': Offset(0, halfH),
      'left': Offset(-halfW, 0),
      'right': Offset(halfW, 0),
    };

    return localSides.map((key, local) {
      final rotated = _rotatePoint(local, rotation);
      return MapEntry(key, center + rotated);
    });
  }

  /// Gets cursor for corner handle based on rotation.
  MouseCursor _getCornerCursor(String corner, double rotation) {
    const baseAngles = {
      'topLeft': 225.0,
      'topRight': 315.0,
      'bottomRight': 45.0,
      'bottomLeft': 135.0,
    };

    var angle = (baseAngles[corner]! + rotation * 180 / math.pi) % 360;
    if (angle < 0) angle += 360;

    // 8 directions, 45° each
    if (angle >= 337.5 || angle < 22.5) {
      return SystemMouseCursors.resizeLeftRight;
    }
    if (angle >= 22.5 && angle < 67.5) {
      return SystemMouseCursors.resizeUpLeftDownRight;
    }
    if (angle >= 67.5 && angle < 112.5) {
      return SystemMouseCursors.resizeUpDown;
    }
    if (angle >= 112.5 && angle < 157.5) {
      return SystemMouseCursors.resizeUpRightDownLeft;
    }
    if (angle >= 157.5 && angle < 202.5) {
      return SystemMouseCursors.resizeLeftRight;
    }
    if (angle >= 202.5 && angle < 247.5) {
      return SystemMouseCursors.resizeUpLeftDownRight;
    }
    if (angle >= 247.5 && angle < 292.5) {
      return SystemMouseCursors.resizeUpDown;
    }
    return SystemMouseCursors.resizeUpRightDownLeft;
  }

  /// Gets cursor for side handle based on rotation.
  MouseCursor _getSideCursor(String side, double rotation) {
    const baseAngles = {
      'top': 270.0,
      'bottom': 90.0,
      'left': 180.0,
      'right': 0.0,
    };

    var angle = (baseAngles[side]! + rotation * 180 / math.pi) % 360;
    if (angle < 0) angle += 360;

    final isVertical =
        (angle >= 45 && angle < 135) || (angle >= 225 && angle < 315);
    return isVertical
        ? SystemMouseCursors.resizeUpDown
        : SystemMouseCursors.resizeLeftRight;
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.image;
    final scale = widget.scale;

    // Calculate scaled dimensions
    final scaledWidth = image.size.width * scale;
    final scaledHeight = image.size.height * scale;

    // Padding must accommodate object at any rotation angle
    // Max extent from center = half diagonal of the rectangle
    final halfDiagonal = math.sqrt(
      scaledWidth * scaledWidth + scaledHeight * scaledHeight,
    ) / 2;
    // Add space for rotation handle at the top (stem + handle radius)
    final padding = halfDiagonal +
        SelectionHandleConstants.rotationHandleTotalHeight +
        SelectionHandleConstants.rotationHandleHitSize / 2;

    // Center of object in screen coordinates
    // When screenOffset is provided, use it (absolute positioning from PlacedImagesLayer)
    // Otherwise calculate from image.position (relative to page, used by PlacedImageOverlay)
    final Offset centerScreen;
    if (widget.screenOffset != null) {
      // screenOffset is top-left corner → center = offset + half size
      centerScreen = Offset(
        widget.screenOffset!.dx + scaledWidth / 2,
        widget.screenOffset!.dy + scaledHeight / 2,
      );
    } else {
      // Legacy: relative to page origin
      centerScreen = Offset(
        (image.position.dx + image.size.width / 2) * scale,
        (image.position.dy + image.size.height / 2) * scale,
      );
    }

    // Center relative to widget origin (widget is square with side = padding * 2)
    final centerLocal = Offset(padding, padding);

    // Compute handle positions in widget's local coordinates
    final cornerPositions =
        _computeCornerPositions(centerLocal, scaledWidth, scaledHeight, image.rotation);
    final sidePositions =
        _computeSidePositions(centerLocal, scaledWidth, scaledHeight, image.rotation);

    // Hit area half sizes for positioning (center of hit area at handle position)
    const halfCornerHit = SelectionHandleConstants.cornerHitSize / 2;
    const halfSideHit = SelectionHandleConstants.sideHitSize / 2;

    return Positioned(
      left: centerScreen.dx - padding,
      top: centerScreen.dy - padding,
      child: SizedBox(
        width: padding * 2,
        height: padding * 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // [1] Image with Transform.rotate OUTSIDE (hit area rotates with image)
            Positioned(
              left: padding - scaledWidth / 2,
              top: padding - scaledHeight / 2,
              child: Transform.rotate(
                angle: image.rotation,
                child: Listener(
                  onPointerDown: (event) => _handlePointerDown(event, 'body'),
                  onPointerUp: _handlePointerUp,
                  onPointerCancel: _handlePointerCancel,
                  child: MouseRegion(
                    cursor: _isDragging
                        ? SystemMouseCursors.grabbing
                        : SystemMouseCursors.grab,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _handleTap,
                      onScaleStart: _handleScaleStart,
                      onScaleUpdate: _handleScaleUpdate,
                      onScaleEnd: _handleScaleEnd,
                      child: SizedBox(
                        width: scaledWidth,
                        height: scaledHeight,
                        child: Stack(
                          children: [
                            // Image
                            Positioned.fill(
                              child: Image.file(
                                File(image.imagePath),
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Selection border (inside rotation)
                            if (widget.isSelected)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: SelectionHandleConstants.selectionBorderColor
                                          .withOpacity(SelectionHandleConstants.inactiveOpacity),
                                      width: SelectionHandleConstants.selectionBorderWidth,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // [2] Rotation handle (single handle at top with stem)
            if (widget.isSelected)
              _buildRotationHandle(
                centerLocal: centerLocal,
                scaledWidth: scaledWidth,
                scaledHeight: scaledHeight,
                rotation: image.rotation,
              ),

            // [3] Corner handles (OUTSIDE rotation, in screen coords)
            if (widget.isSelected)
              for (final corner in ['topLeft', 'topRight', 'bottomLeft', 'bottomRight'])
                Positioned(
                  left: cornerPositions[corner]!.dx - halfCornerHit,
                  top: cornerPositions[corner]!.dy - halfCornerHit,
                  child: _CornerHandle(
                    corner: corner,
                    cursor: _getCornerCursor(corner, image.rotation),
                    onDrag: (delta) => _handleCornerDrag(corner, delta),
                    isRotating: _isRotating,
                    isActive: _activeHandle == 'corner:$corner',
                    onPointerDown: (event) => _handlePointerDown(event, 'corner:$corner'),
                    onPointerUp: _handlePointerUp,
                    onPointerCancel: _handlePointerCancel,
                  ),
                ),

            // [4] Side handles (OUTSIDE rotation, in screen coords)
            if (widget.isSelected)
              for (final side in ['top', 'bottom', 'left', 'right'])
                Positioned(
                  left: sidePositions[side]!.dx - halfSideHit,
                  top: sidePositions[side]!.dy - halfSideHit,
                  child: _SideHandle(
                    side: side,
                    cursor: _getSideCursor(side, image.rotation),
                    onDrag: (delta) => _handleSideDrag(side, delta),
                    isRotating: _isRotating,
                    isActive: _activeHandle == 'side:$side',
                    onPointerDown: (event) => _handlePointerDown(event, 'side:$side'),
                    onPointerUp: _handlePointerUp,
                    onPointerCancel: _handlePointerCancel,
                  ),
                ),

            // [5] Size label (positioned at visually bottom edge)
            if (widget.isSelected)
              Builder(
                builder: (context) {
                  final bottomInfo = _findBottomEdge(
                    widgetCenter: centerLocal,
                    scaledWidth: scaledWidth,
                    scaledHeight: scaledHeight,
                    rotation: image.rotation,
                    originalWidth: image.size.width,
                    originalHeight: image.size.height,
                  );

                  // Offset perpendicular to edge (outward from object)
                  const labelOffset = 16.0;
                  Offset outward;
                  switch (bottomInfo.edge) {
                    case 'top':
                      outward = _rotatePoint(const Offset(0, -1), image.rotation);
                    case 'bottom':
                      outward = _rotatePoint(const Offset(0, 1), image.rotation);
                    case 'left':
                      outward = _rotatePoint(const Offset(-1, 0), image.rotation);
                    case 'right':
                      outward = _rotatePoint(const Offset(1, 0), image.rotation);
                    default:
                      outward = _rotatePoint(const Offset(0, 1), image.rotation);
                  }

                  final labelPos = bottomInfo.center + outward * labelOffset;

                  return Positioned(
                    left: labelPos.dx,
                    top: labelPos.dy,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, -0.5),
                      child: Transform.rotate(
                        angle: bottomInfo.labelRotation,
                        child: SizeLabel(
                          firstDimension: bottomInfo.firstDim,
                          secondDimension: bottomInfo.secondDim,
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  /// Builds the rotation handle at the top of the object with a stem.
  Widget _buildRotationHandle({
    required Offset centerLocal,
    required double scaledWidth,
    required double scaledHeight,
    required double rotation,
  }) {
    const stemLength = SelectionHandleConstants.rotationHandleStemLength;
    const handleSize = SelectionHandleConstants.rotationHandleSize;
    const hitSize = SelectionHandleConstants.rotationHandleHitSize;

    // Top edge center in local coords (before rotation)
    final halfH = scaledHeight / 2;
    final topEdgeLocal = Offset(0, -halfH);

    // Rotate to get screen position
    final topEdgeScreen = centerLocal + _rotatePoint(topEdgeLocal, rotation);

    // Direction "up" from top edge (outward, perpendicular to top edge)
    final upDirection = _rotatePoint(const Offset(0, -1), rotation);

    // Stem start (on the edge of object) and end (center of handle)
    final stemStart = topEdgeScreen;
    final handleCenter = topEdgeScreen + upDirection * (stemLength + handleSize / 2);

    // Active or hovered state
    final isActive = _activeHandle == 'rotate:top';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Stem line
        Positioned.fill(
          child: CustomPaint(
            painter: _StemPainter(
              start: stemStart,
              end: handleCenter,
              color: isActive
                  ? SelectionHandleConstants.handleActiveColor
                  : SelectionHandleConstants.handleActiveColor
                      .withOpacity(SelectionHandleConstants.inactiveOpacity),
            ),
          ),
        ),
        // Handle circle with hit area
        Positioned(
          left: handleCenter.dx - hitSize / 2,
          top: handleCenter.dy - hitSize / 2,
          child: _RotationHandle(
            onDragStart: _handleRotateDragStart,
            onDrag: _handleRotateDrag,
            onDragEnd: _handleRotateDragEnd,
            isActive: isActive,
            onPointerDown: (event) => _handlePointerDown(event, 'rotate:top'),
            onPointerUp: _handlePointerUp,
            onPointerCancel: _handlePointerCancel,
          ),
        ),
      ],
    );
  }

  // ==========================================================================
  // POINTER TRACKING (for gesture routing)
  // ==========================================================================

  void _handlePointerDown(PointerDownEvent event, String handleType) {
    _activePointers.add(event.pointer);
    ref.read(pointerOnObjectProvider.notifier).pointerDown(
          event.pointer,
          widget.image.id,
        );
    setState(() => _activeHandle = handleType);
  }

  void _handlePointerUp(PointerUpEvent event) {
    _activePointers.remove(event.pointer);
    ref.read(pointerOnObjectProvider.notifier).pointerUp(event.pointer);
    if (_activePointers.isEmpty) {
      setState(() => _activeHandle = null);
    }
  }

  void _handlePointerCancel(PointerCancelEvent event) {
    _activePointers.remove(event.pointer);
    ref.read(pointerOnObjectProvider.notifier).pointerUp(event.pointer);
    if (_activePointers.isEmpty) {
      setState(() => _activeHandle = null);
    }
  }

  void _handleTap() {
    ref.read(editorSelectionProvider.notifier).select(widget.image.id);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    setState(() => _isDragging = true);
    // Select the image when starting to drag
    ref.read(editorSelectionProvider.notifier).select(widget.image.id);

    // Save initial state for pinch scaling and rotation
    if (details.pointerCount >= 2) {
      _scaleStartWidth = widget.image.size.width;
      _twoFingerStartRotation = widget.image.rotation;
      _lastHapticQuadrant = _getQuadrant(widget.image.rotation);
    }
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (details.pointerCount == 1) {
      // One finger — movement (same as before)
      // focalPointDelta is in rotated local coordinates (GestureDetector is inside Transform.rotate)
      final localDelta = details.focalPointDelta / widget.scale;
      final pdfDelta = _rotatePoint(localDelta, widget.image.rotation);
      final newPosition = widget.image.position + pdfDelta;

      ref.read(placedImagesProvider.notifier).moveImage(
            widget.image.id,
            newPosition,
          );
    } else if (details.pointerCount >= 2) {
      // Two fingers — pinch scaling + rotation
      if (_scaleStartWidth != null) {
        _handlePinchScale(details.scale);
      }
      if (_twoFingerStartRotation != null) {
        _handleTwoFingerRotation(details.rotation);
      }
    }
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() => _isDragging = false);
    _scaleStartWidth = null;
    _twoFingerStartRotation = null;
    _lastHapticQuadrant = null;
  }

  void _handlePinchScale(double scaleFactor) {
    final image = widget.image;
    final aspectRatio = image.size.width / image.size.height;

    // Compute new size
    var newWidth = _scaleStartWidth! * scaleFactor;
    var newHeight = newWidth / aspectRatio;

    // Apply minimum size constraint
    const minSize = SelectionHandleConstants.minObjectSize;
    if (newWidth < minSize || newHeight < minSize) {
      if (aspectRatio >= 1) {
        newWidth = minSize;
        newHeight = minSize / aspectRatio;
      } else {
        newHeight = minSize;
        newWidth = minSize * aspectRatio;
      }
    }

    // Scale from center
    final center = image.center;
    final newPosition = Offset(
      center.dx - newWidth / 2,
      center.dy - newHeight / 2,
    );

    ref.read(placedImagesProvider.notifier).transformImage(
          image.id,
          position: newPosition,
          size: Size(newWidth, newHeight),
        );
  }

  void _handleTwoFingerRotation(double rotationDelta) {
    final newRotation = _twoFingerStartRotation! + rotationDelta;

    // Haptic feedback when crossing cardinal angles (0°, 90°, 180°, 270°)
    final newQuadrant = _getQuadrant(newRotation);
    if (newQuadrant != _lastHapticQuadrant) {
      HapticFeedback.lightImpact();
      _lastHapticQuadrant = newQuadrant;
    }

    ref.read(placedImagesProvider.notifier).rotateImage(
          widget.image.id,
          newRotation,
        );
  }

  /// Returns quadrant (0-3) based on angle for haptic feedback.
  /// 0: around 0°, 1: around 90°, 2: around 180°, 3: around 270°
  int _getQuadrant(double rotation) {
    // Normalize to 0-2π
    var angle = rotation % (2 * math.pi);
    if (angle < 0) angle += 2 * math.pi;

    // Each quadrant is 90° (π/2 radians)
    // Centered around cardinal angles: 0°, 90°, 180°, 270°
    if (angle < math.pi / 4 || angle >= 7 * math.pi / 4) return 0; // ~0°
    if (angle < 3 * math.pi / 4) return 1; // ~90°
    if (angle < 5 * math.pi / 4) return 2; // ~180°
    return 3; // ~270°
  }

  // ==========================================================================
  // CORNER DRAG (resize only - no rotation)
  // ==========================================================================

  void _handleCornerDrag(String corner, Offset delta) {
    final image = widget.image;
    final pdfDelta = delta / widget.scale;
    final localDelta = _transformToLocal(pdfDelta, image.rotation);

    // Corner handles always do proportional resize
    _handleProportionalResize(corner, localDelta);
  }

  void _handleProportionalResize(String corner, Offset localDelta) {
    final image = widget.image;
    final oldWidth = image.size.width;
    final oldHeight = image.size.height;
    final oldCenter = image.center;
    const minSize = SelectionHandleConstants.minObjectSize;

    // Determine target width based on corner (scale by width only)
    double targetWidth;
    switch (corner) {
      case 'topLeft':
      case 'bottomLeft':
        targetWidth = oldWidth - localDelta.dx;
      case 'topRight':
      case 'bottomRight':
        targetWidth = oldWidth + localDelta.dx;
      default:
        return;
    }

    // Scale proportionally by width
    var scale = targetWidth / oldWidth;
    var newWidth = oldWidth * scale;
    var newHeight = oldHeight * scale;

    // Enforce minimum size on both axes
    if (newWidth < minSize || newHeight < minSize) {
      final minScale = math.max(minSize / oldWidth, minSize / oldHeight);
      scale = minScale;
      newWidth = oldWidth * scale;
      newHeight = oldHeight * scale;
    }

    // Fix opposite corner by shifting center
    final actualWidthDelta = newWidth - oldWidth;
    final actualHeightDelta = newHeight - oldHeight;

    Offset localCenterShift;
    switch (corner) {
      case 'topLeft':
        localCenterShift = Offset(-actualWidthDelta / 2, -actualHeightDelta / 2);
      case 'topRight':
        localCenterShift = Offset(actualWidthDelta / 2, -actualHeightDelta / 2);
      case 'bottomLeft':
        localCenterShift = Offset(-actualWidthDelta / 2, actualHeightDelta / 2);
      case 'bottomRight':
        localCenterShift = Offset(actualWidthDelta / 2, actualHeightDelta / 2);
      default:
        localCenterShift = Offset.zero;
    }

    // Transform center shift back to PDF coordinates
    final pdfCenterShift = _rotatePoint(localCenterShift, image.rotation);
    final newCenter = oldCenter + pdfCenterShift;
    final newPosition = Offset(
      newCenter.dx - newWidth / 2,
      newCenter.dy - newHeight / 2,
    );

    ref.read(placedImagesProvider.notifier).transformImage(
          image.id,
          position: newPosition,
          size: Size(newWidth, newHeight),
        );
  }

  // ==========================================================================
  // SIDE DRAG (non-proportional stretch)
  // ==========================================================================

  void _handleSideDrag(String side, Offset delta) {
    final image = widget.image;
    final pdfDelta = delta / widget.scale;
    final localDelta = _transformToLocal(pdfDelta, image.rotation);

    var newWidth = image.size.width;
    var newHeight = image.size.height;
    var newX = image.position.dx;
    var newY = image.position.dy;

    const minSize = SelectionHandleConstants.minObjectSize;

    switch (side) {
      case 'top':
        final newH =
            (image.size.height - localDelta.dy).clamp(minSize, double.infinity);
        newY = image.position.dy + (image.size.height - newH);
        newHeight = newH;
      case 'bottom':
        newHeight =
            (image.size.height + localDelta.dy).clamp(minSize, double.infinity);
      case 'left':
        final newW =
            (image.size.width - localDelta.dx).clamp(minSize, double.infinity);
        newX = image.position.dx + (image.size.width - newW);
        newWidth = newW;
      case 'right':
        newWidth =
            (image.size.width + localDelta.dx).clamp(minSize, double.infinity);
    }

    ref.read(placedImagesProvider.notifier).transformImage(
          image.id,
          position: Offset(newX, newY),
          size: Size(newWidth, newHeight),
        );
  }

  // ==========================================================================
  // ROTATION (from rotate zones)
  // ==========================================================================

  void _handleRotateDragStart() {
    setState(() => _isRotating = true);
    _rotateStartRotation = widget.image.rotation;
    _rotateStartAngle = null;
  }

  void _handleRotateDrag(Offset globalPosition) {
    final image = widget.image;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final localPos = renderBox.globalToLocal(globalPosition);

    // Compute center position in widget's local coordinates
    // The widget is centered around the object center with padding for handles
    final scaledWidth = image.size.width * widget.scale;
    final scaledHeight = image.size.height * widget.scale;
    final halfDiagonal = math.sqrt(
      scaledWidth * scaledWidth + scaledHeight * scaledHeight,
    ) / 2;
    final padding = halfDiagonal +
        SelectionHandleConstants.rotationHandleTotalHeight +
        SelectionHandleConstants.rotationHandleHitSize / 2;
    final centerLocal = Offset(padding, padding);

    final currentAngle = (localPos - centerLocal).direction;

    // Save start angle on first update
    if (_rotateStartAngle == null) {
      _rotateStartAngle = currentAngle;
      return;
    }

    // Compute angle delta with normalization for smooth ±180° transition
    var angleDelta = currentAngle - _rotateStartAngle!;
    while (angleDelta > math.pi) {
      angleDelta -= 2 * math.pi;
    }
    while (angleDelta < -math.pi) {
      angleDelta += 2 * math.pi;
    }

    final newRotation = _rotateStartRotation! + angleDelta;
    ref.read(placedImagesProvider.notifier).rotateImage(image.id, newRotation);
  }

  void _handleRotateDragEnd() {
    setState(() => _isRotating = false);
    _rotateStartRotation = null;
    _rotateStartAngle = null;
  }

  // ==========================================================================
  // SIZE LABEL (positioned at visually bottom edge)
  // ==========================================================================

  /// Finds the visually bottom edge (maximum Y center in screen coords).
  ///
  /// Returns edge name, center position, label rotation, and dimensions.
  ({
    String edge,
    Offset center,
    double labelRotation,
    double firstDim,
    double secondDim,
  }) _findBottomEdge({
    required Offset widgetCenter,
    required double scaledWidth,
    required double scaledHeight,
    required double rotation,
    required double originalWidth,
    required double originalHeight,
  }) {
    final halfW = scaledWidth / 2;
    final halfH = scaledHeight / 2;

    // Edge centers in local coords (before rotation)
    final localCenters = {
      'top': Offset(0, -halfH),
      'bottom': Offset(0, halfH),
      'left': Offset(-halfW, 0),
      'right': Offset(halfW, 0),
    };

    // Find edge with max Y in screen coords
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

    // Screen position of bottom edge center
    final localCenter = localCenters[bottomEdge]!;
    final screenCenter = widgetCenter + _rotatePoint(localCenter, rotation);

    // Label rotation = parallel to edge, but normalized to be readable
    double labelRotation;
    double firstDim;
    double secondDim;

    switch (bottomEdge) {
      case 'top':
        labelRotation = rotation + math.pi; // flipped 180°
        firstDim = originalWidth;
        secondDim = originalHeight;
      case 'bottom':
        labelRotation = rotation;
        firstDim = originalWidth;
        secondDim = originalHeight;
      case 'left':
        labelRotation = rotation - math.pi / 2;
        firstDim = originalHeight;
        secondDim = originalWidth;
      case 'right':
        labelRotation = rotation + math.pi / 2;
        firstDim = originalHeight;
        secondDim = originalWidth;
      default:
        labelRotation = rotation;
        firstDim = originalWidth;
        secondDim = originalHeight;
    }

    // Normalize angle to [-π/2, π/2] so text is readable (not upside down)
    while (labelRotation > math.pi / 2) {
      labelRotation -= math.pi;
    }
    while (labelRotation < -math.pi / 2) {
      labelRotation += math.pi;
    }

    return (
      edge: bottomEdge,
      center: screenCenter,
      labelRotation: labelRotation,
      firstDim: firstDim,
      secondDim: secondDim,
    );
  }
}

/// Corner handle widget (circle, for proportional resize).
class _CornerHandle extends StatefulWidget {
  const _CornerHandle({
    required this.corner,
    required this.cursor,
    required this.onDrag,
    required this.onPointerDown,
    required this.onPointerUp,
    required this.onPointerCancel,
    this.isRotating = false,
    this.isActive = false,
  });

  final String corner;
  final MouseCursor cursor;
  final void Function(Offset delta) onDrag;
  final void Function(PointerDownEvent) onPointerDown;
  final void Function(PointerUpEvent) onPointerUp;
  final void Function(PointerCancelEvent) onPointerCancel;
  final bool isRotating;
  final bool isActive;

  @override
  State<_CornerHandle> createState() => _CornerHandleState();
}

class _CornerHandleState extends State<_CornerHandle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.cornerHitSize;
    const visualSize = SelectionHandleConstants.cornerHandleSize;

    // Active or hovered = bright, otherwise pale
    final isHighlighted = widget.isActive || _isHovered;
    final fillColor = isHighlighted
        ? SelectionHandleConstants.handleActiveColor
        : SelectionHandleConstants.handleActiveColor
            .withOpacity(SelectionHandleConstants.inactiveOpacity);
    final borderColor = isHighlighted
        ? SelectionHandleConstants.handleBorderColor
        : SelectionHandleConstants.handleBorderColor
            .withOpacity(SelectionHandleConstants.inactiveOpacity);

    // Use grabbing cursor during rotation to override handle cursor
    final cursor =
        widget.isRotating ? SystemMouseCursors.grabbing : widget.cursor;

    return Listener(
      onPointerDown: widget.onPointerDown,
      onPointerUp: widget.onPointerUp,
      onPointerCancel: widget.onPointerCancel,
      child: MouseRegion(
        cursor: cursor,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) => widget.onDrag(details.delta),
          child: SizedBox(
            width: hitSize,
            height: hitSize,
            child: Center(
              child: Container(
                width: visualSize,
                height: visualSize,
                decoration: BoxDecoration(
                  color: fillColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: SelectionHandleConstants.handleBorderWidth,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Side handle widget (circle, for non-proportional stretch).
class _SideHandle extends StatefulWidget {
  const _SideHandle({
    required this.side,
    required this.cursor,
    required this.onDrag,
    required this.onPointerDown,
    required this.onPointerUp,
    required this.onPointerCancel,
    this.isRotating = false,
    this.isActive = false,
  });

  final String side;
  final MouseCursor cursor;
  final void Function(Offset delta) onDrag;
  final void Function(PointerDownEvent) onPointerDown;
  final void Function(PointerUpEvent) onPointerUp;
  final void Function(PointerCancelEvent) onPointerCancel;
  final bool isRotating;
  final bool isActive;

  @override
  State<_SideHandle> createState() => _SideHandleState();
}

class _SideHandleState extends State<_SideHandle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.sideHitSize;
    const visualSize = SelectionHandleConstants.sideHandleSize;

    // Active or hovered = bright, otherwise pale
    final isHighlighted = widget.isActive || _isHovered;
    final fillColor = isHighlighted
        ? SelectionHandleConstants.handleActiveColor
        : SelectionHandleConstants.handleActiveColor
            .withOpacity(SelectionHandleConstants.inactiveOpacity);
    final borderColor = isHighlighted
        ? SelectionHandleConstants.handleBorderColor
        : SelectionHandleConstants.handleBorderColor
            .withOpacity(SelectionHandleConstants.inactiveOpacity);

    // Use grabbing cursor during rotation to override handle cursor
    final cursor =
        widget.isRotating ? SystemMouseCursors.grabbing : widget.cursor;

    return Listener(
      onPointerDown: widget.onPointerDown,
      onPointerUp: widget.onPointerUp,
      onPointerCancel: widget.onPointerCancel,
      child: MouseRegion(
        cursor: cursor,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) => widget.onDrag(details.delta),
          child: SizedBox(
            width: hitSize,
            height: hitSize,
            child: Center(
              child: Container(
                width: visualSize,
                height: visualSize,
                decoration: BoxDecoration(
                  color: fillColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: SelectionHandleConstants.handleBorderWidth,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rotation handle widget (circle at top with stem).
class _RotationHandle extends StatefulWidget {
  const _RotationHandle({
    required this.onDragStart,
    required this.onDrag,
    required this.onDragEnd,
    required this.onPointerDown,
    required this.onPointerUp,
    required this.onPointerCancel,
    this.isActive = false,
  });

  final VoidCallback onDragStart;
  final void Function(Offset globalPosition) onDrag;
  final VoidCallback onDragEnd;
  final void Function(PointerDownEvent) onPointerDown;
  final void Function(PointerUpEvent) onPointerUp;
  final void Function(PointerCancelEvent) onPointerCancel;
  final bool isActive;

  @override
  State<_RotationHandle> createState() => _RotationHandleState();
}

class _RotationHandleState extends State<_RotationHandle> {
  bool _isDragging = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.rotationHandleHitSize;
    const visualSize = SelectionHandleConstants.rotationHandleSize;

    // Active or hovered = bright, otherwise pale
    final isHighlighted = widget.isActive || _isHovered || _isDragging;
    final fillColor = isHighlighted
        ? SelectionHandleConstants.handleActiveColor
        : SelectionHandleConstants.handleActiveColor
            .withOpacity(SelectionHandleConstants.inactiveOpacity);
    final borderColor = isHighlighted
        ? SelectionHandleConstants.handleBorderColor
        : SelectionHandleConstants.handleBorderColor
            .withOpacity(SelectionHandleConstants.inactiveOpacity);

    return Listener(
      onPointerDown: widget.onPointerDown,
      onPointerUp: widget.onPointerUp,
      onPointerCancel: widget.onPointerCancel,
      child: MouseRegion(
        cursor: _isDragging
            ? SystemMouseCursors.grabbing
            : SystemMouseCursors.grab,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (details) {
            setState(() => _isDragging = true);
            widget.onDragStart();
          },
          onPanUpdate: (details) {
            widget.onDrag(details.globalPosition);
          },
          onPanEnd: (_) {
            setState(() => _isDragging = false);
            widget.onDragEnd();
          },
          child: SizedBox(
            width: hitSize,
            height: hitSize,
            child: Center(
              child: Container(
                width: visualSize,
                height: visualSize,
                decoration: BoxDecoration(
                  color: fillColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: SelectionHandleConstants.handleBorderWidth,
                  ),
                ),
                // Rotation icon inside the handle
                child: Icon(
                  Icons.refresh,
                  size: visualSize * 0.6,
                  color: borderColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the stem line from object edge to rotation handle.
class _StemPainter extends CustomPainter {
  _StemPainter({
    required this.start,
    required this.end,
    required this.color,
  });

  final Offset start;
  final Offset end;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = SelectionHandleConstants.rotationStemWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(_StemPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.color != color;
  }
}
