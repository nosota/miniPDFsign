# ADR-004: Background Removal for Images

**Status:** Accepted
**Date:** 2026-02-05
**Updated:** 2026-02-07

## Context

Users often add signatures and stamps that were photographed or scanned on white paper. These images have opaque white backgrounds that obscure the PDF content beneath them. Users need a way to make the background transparent so only the signature/stamp is visible.

Key requirements:
1. Automatic detection of uniform backgrounds
2. High-quality removal preserving fine details
3. Sharp edges (not blurry) suitable for document use
4. Works offline without cloud services
5. Cross-platform (iOS and Android)

## Decision

Implement a **three-stage** background removal pipeline: Detection (Dart) → ML Segmentation (Native) → Post-ML Cleanup (Native).

### Stage 1: Detection (Dart)

`BackgroundDetectionService` analyzes image perimeter to detect uniform backgrounds:

- Sample 80 pixels along all 4 edges (20 per edge)
- Calculate mean RGB color and standard deviation
- If variance ≤ 25 → uniform background detected
- Skip images that already have transparency

### Stage 2: ML Segmentation (Native)

Use platform-specific ML APIs with color-based fallback:

**iOS:**
- iOS 17+: `VNGenerateForegroundInstanceMaskRequest` (Vision framework)
- Fallback: Color-based removal using Core Graphics

**Android:**
- API 24+: ML Kit Subject Segmentation API
- Fallback: Color-based removal using Bitmap manipulation

#### Sharp Edge Processing

ML segmentation produces soft/feathered edges (gradient alpha). For stamps and signatures, we apply **binary threshold** at 50% confidence:

```
if confidence >= 0.5:
    alpha = 255  (fully opaque)
else:
    alpha = 0    (fully transparent)
```

This produces crisp boundaries instead of blurry edges.

### Stage 3: Post-ML Cleanup — Histogram + HSV + RGB Triple Criteria

#### Problem

ML segmentation treats enclosed areas (inside round stamps, text loops, etc.) as foreground — the model sees paper surrounded by ink and keeps it. This leaves opaque paper-colored patches inside the stamp that should be transparent.

A naive approach of "detect background by sampling 4 corners, remove with tolerance=35" fails because:
- Corner sampling detects the *outer* background — which ML already removed
- `colorTolerance=35` is too narrow for real camera photos where paper color varies due to uneven lighting (actual distance to paper can be 40-80)
- The approach has no way to distinguish paper from light-colored ink

#### Solution: Two-Phase Post-ML Algorithm

**Phase 1 — Histogram-based dominant color detection:**

Among all opaque pixels remaining after ML segmentation (ink + trapped paper), paper pixels are the majority. We quantize the RGB space into 4096 buckets (16 divisions per channel) and find the most populated bucket. The average RGB of that bucket is the dominant color — i.e., the paper color.

```
bucketIndex = (R / 16) * 256 + (G / 16) * 16 + (B / 16)
→ 4096 buckets, each covering a 16×16×16 RGB cube
→ Find bucket with highest pixel count
→ Dominant color = average RGB within that bucket
```

This is more robust than corner sampling because it uses *all* opaque pixels, automatically adapting to any paper color and lighting conditions.

**Phase 2 — Triple criteria for safe removal:**

A pixel is removed (alpha → 0) only if **ALL THREE** conditions are met:

| # | Criterion | Threshold | Purpose |
|---|-----------|-----------|---------|
| 1 | RGB distance from dominant color | < 80 | Pixel must be close to paper color |
| 2 | HSV Saturation | < 0.20 | Paper is unsaturated; protects colored ink |
| 3 | HSL Lightness | > 0.70 | Paper is bright; protects black ink and pencil |

The combination of three independent criteria provides safety margins that no single threshold can achieve:

| Pixel Type | RGB dist | HSV Sat | HSL Light | Removed? | Protecting criterion |
|------------|----------|---------|-----------|----------|---------------------|
| White paper | ~0 | ~0.0 | ~1.0 | Yes | — |
| Cream paper | ~25 | ~0.06 | ~0.95 | Yes | — |
| Shadowed paper | ~50 | ~0.03 | ~0.75 | Yes | — |
| Deep shadow | ~90+ | low | ~0.60 | No | distance + lightness |
| Blue ink | ~150+ | ~0.6+ | varies | No | saturation |
| Red ink | ~200+ | ~0.8+ | varies | No | saturation |
| Black ink | ~250 | ~0.0 | ~0.05 | No | lightness |
| Gray pencil | ~100+ | ~0.0 | ~0.50 | No | distance + lightness |

#### Why HSV Saturation, Not HSL

A critical detail: the saturation formula uses **HSV** (`(max - min) / max`), not HSL (`delta / (2 - max - min)`). HSL saturation degenerates near L=1.0 — for cream paper RGB(255, 253, 240), HSL gives S=1.0 while HSV gives S=0.059. HSL would make the saturation criterion useless for any non-pure-white paper.

#### Constants

```
postMLRGBDistanceThreshold = 80.0
postMLSaturationThreshold  = 0.20   (HSV saturation)
postMLLightnessThreshold   = 0.70   (HSL lightness)
histogramBucketDivisor     = 16     (→ 4096 buckets)
```

#### Performance

For a 12MP image (3000×4000 pixels): histogram pass ~15ms + criteria pass ~15ms = ~30ms total. Negligible compared to ML inference (500ms–2s). Histogram arrays are 4 × 4096 × 4 bytes = 64KB, fitting in L1 cache.

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
- **Clean interiors**: Post-ML cleanup removes trapped paper inside stamps
- **Robust**: Histogram adapts to any paper color and lighting conditions
- **Safe**: Triple criteria protect ink of all colors from accidental removal
- **Graceful fallback**: Color-based removal works when ML fails

### Negative

- **Platform dependency**: Different implementations for iOS/Android
- **iOS version requirement**: Best results require iOS 17+
- **Model download**: ML Kit may download models on first use (Android)
- **Dense stamps**: If a stamp is mostly ink with very little paper inside, the histogram may identify ink as dominant — cleanup won't remove the small paper areas (acceptable degradation)

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

### 5. Corner-sampled background + single tolerance

The initial post-ML approach: sample 4 corner pixels of the original image, use `colorTolerance=35` to remove similar pixels.

**Superseded because:**
- Corner sampling detects outer background (already removed by ML)
- Tolerance of 35 is too narrow for camera photos with uneven lighting
- No protection for light-colored ink — a single distance threshold cannot distinguish cream paper from light blue ink

### 6. Pure HSL filtering (without histogram)

Removing all low-saturation, high-lightness pixels regardless of the actual paper color.

**Rejected because:**
- Would remove light gray pencil marks (S≈0, L≈0.50–0.70)
- The RGB distance criterion anchored to the actual paper color provides an important additional safety margin

## References

- [Vision Framework - VNGenerateForegroundInstanceMaskRequest](https://developer.apple.com/documentation/vision/vngenerateforegroundinstancemaskrequest)
- [ML Kit Subject Segmentation](https://developers.google.com/ml-kit/vision/subject-segmentation)
- [HSV color model — Wikipedia](https://en.wikipedia.org/wiki/HSL_and_HSV)
- Related: [ADR-001 Clean Architecture](./001-clean-architecture.md)
