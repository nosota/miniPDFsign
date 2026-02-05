# ADR-004: Background Removal for Images

**Status:** Accepted
**Date:** 2026-02-05

## Context

Users often add signatures and stamps that were photographed or scanned on white paper. These images have opaque white backgrounds that obscure the PDF content beneath them. Users need a way to make the background transparent so only the signature/stamp is visible.

Key requirements:
1. Automatic detection of uniform backgrounds
2. High-quality removal preserving fine details
3. Sharp edges (not blurry) suitable for document use
4. Works offline without cloud services
5. Cross-platform (iOS and Android)

## Decision

Implement a two-stage background removal system:

### Stage 1: Detection (Dart)

`BackgroundDetectionService` analyzes image perimeter to detect uniform backgrounds:

- Sample 80 pixels along all 4 edges (20 per edge)
- Calculate mean RGB color and standard deviation
- If variance ≤ 25 → uniform background detected
- Skip images that already have transparency

### Stage 2: Removal (Native)

Use platform-specific ML APIs with color-based fallback:

**iOS:**
- iOS 17+: `VNGenerateForegroundInstanceMaskRequest` (Vision framework)
- Fallback: Color-based removal using Core Graphics

**Android:**
- API 24+: ML Kit Subject Segmentation API
- Fallback: Color-based removal using Bitmap manipulation

### Sharp Edge Processing

ML segmentation produces soft/feathered edges (gradient alpha). For stamps and signatures, we apply **binary threshold** at 50% confidence:

```
if confidence >= 0.5:
    alpha = 255  (fully opaque)
else:
    alpha = 0    (fully transparent)
```

This produces crisp boundaries instead of blurry edges.

### User Interaction

- Detection happens automatically after image selection
- User is prompted with dialog: "Remove Background?"
- User can choose "Remove" or "Keep"
- Processing happens in background thread

## Consequences

### Positive

- **Automatic**: Users don't need to manually edit images
- **Offline**: All processing happens on-device
- **Fast**: Native ML APIs are hardware-accelerated
- **Quality**: ML-based removal handles complex edges well
- **Sharp**: Threshold-based alpha produces document-quality results
- **Graceful fallback**: Color-based removal works when ML fails

### Negative

- **Platform dependency**: Different implementations for iOS/Android
- **iOS version requirement**: Best results require iOS 17+
- **Model download**: ML Kit may download models on first use (Android)
- **Edge cases**: Very complex backgrounds may not be detected/removed properly

### Neutral

- **Binary decision**: No option for partial transparency (by design)
- **Perimeter sampling**: May miss backgrounds that don't extend to edges

## Alternatives Considered

### 1. Cloud-based removal (Removed.bg, etc.)

**Rejected because:**
- Requires internet connection
- Privacy concerns (uploading user documents)
- Recurring API costs
- Latency

### 2. Manual selection/eraser tool

**Rejected because:**
- Poor UX for mobile users
- Time-consuming
- Requires artistic skill

### 3. Chroma key (green screen)

**Rejected because:**
- Requires specific background color
- Not suitable for existing photos/scans

### 4. Gradient alpha (soft edges)

**Rejected because:**
- Produces blurry edges unsuitable for documents
- Stamps/signatures need crisp boundaries

## References

- [Vision Framework - VNGenerateForegroundInstanceMaskRequest](https://developer.apple.com/documentation/vision/vngenerateforegroundinstancemaskrequest)
- [ML Kit Subject Segmentation](https://developers.google.com/ml-kit/vision/subject-segmentation)
- Related: [ADR-001 Clean Architecture](./001-clean-architecture.md)
