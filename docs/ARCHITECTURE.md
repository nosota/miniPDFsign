# miniPDFSign Architecture

This document describes the high-level architecture of the miniPDFSign application.

## Overview

miniPDFSign is a mobile-first application (iOS/Android) for signing and stamping PDF documents. It also supports opening images, which are automatically converted to A4 PDFs. It follows **Clean Architecture** principles with clear separation between layers.

## Layer Structure

```
lib/
├── core/           # Shared kernel (constants, errors, services, theme, utils)
├── domain/         # Business logic (entities, repository interfaces)
├── data/           # Data sources, models, repository implementations, services
├── presentation/   # UI layer (screens, widgets, providers)
├── l10n/           # Localization (60+ languages)
└── main.dart       # Application entry point
```

## Dependency Flow

```
┌─────────────────────────────────────────────────────┐
│                  Presentation Layer                  │
│         (Screens, Widgets, Providers)               │
└─────────────────────┬───────────────────────────────┘
                      │ depends on
                      ▼
┌─────────────────────────────────────────────────────┐
│                   Domain Layer                       │
│        (Entities, Repository Interfaces)            │
└─────────────────────┬───────────────────────────────┘
                      │ implemented by
                      ▼
┌─────────────────────────────────────────────────────┐
│                    Data Layer                        │
│    (Repository Implementations, Data Sources)       │
└─────────────────────────────────────────────────────┘
```

## Core Layer (`lib/core/`)

Shared utilities available to all layers:

| Directory | Purpose |
|-----------|---------|
| `constants/` | App-wide constants (spacing, radii, sidebar layout, image limits, recent files limit) |
| `errors/` | Base `Failure` class and specific failure types (FileNotFound, FileAccess, InvalidFileFormat, FileSizeLimit, PasswordRequired, PasswordIncorrect, WriteProtected, Storage, RenderCancelled, PdfLoad, PdfRender, Unknown, Share) |
| `services/` | `NativeSettingsService` — bridge to iOS UserDefaults / Android SharedPreferences |
| `theme/` | Material 3 theming (colors, typography, shadows, theme data) |
| `utils/` | Utility functions (date formatting, image size calculations, logging, platform detection) |

## Domain Layer (`lib/domain/`)

Pure Dart business logic with no Flutter dependencies:

### Entities

| Entity | Purpose |
|--------|---------|
| `PdfDocumentInfo` | PDF document metadata (filePath, fileName, pageCount, pages, isPasswordProtected) |
| `PdfPageInfo` | Single page metadata (dimensions, rotation) |
| `PlacedImage` | Image placed on PDF (id, sourceImageId, imagePath, pageIndex, position, size, rotation) |
| `SidebarImage` | Image in library (id, fileName, filePath, width, height, fileSize, dateAdded) |
| `RecentFile` | Recently opened file (path, timestamp, displayName) |
| `WindowInfo` | Window metadata (size, position) |

### Repository Interfaces

| Repository | Purpose |
|------------|---------|
| `PdfDocumentRepository` | PDF loading, rendering, password handling |
| `FilePickerRepository` | File selection and validation |
| `SidebarImageRepository` | Image library CRUD operations |
| `RecentFilesRepository` | Recent files management with bookmarks |

## Data Layer (`lib/data/`)

Implementation of data operations:

### Data Sources

| Source | Storage | Purpose |
|--------|---------|---------|
| `PdfDataSource` | pdfx library | PDF rendering with cancellation |
| `FilePickerDataSource` | file_picker | Native file picker |
| `SidebarImageLocalDataSource` | Isar database | Image library storage |
| `RecentFilesLocalDataSource` | SharedPreferences | Recent files list |

### Services

| Service | Purpose |
|---------|---------|
| `PdfSaveService` | Embeds images into PDF using Syncfusion |
| `PdfShareService` | Shares PDF via system share sheet |
| `ImageStorageService` | Copies images to app storage |
| `ImageValidationService` | Validates format/size/resolution, normalizes EXIF orientation |
| `ImageNormalizationService` | Bakes EXIF rotation into pixel data for correct display |
| `ImagePickerService` | Picks images from files or gallery |
| `ImageToPdfService` | Converts single/multiple images to A4 PDFs with EXIF normalization |
| `BackgroundDetectionService` | Detects uniform background on image perimeter |
| `BackgroundRemovalService` | Removes background via 3-stage pipeline: ML segmentation → post-ML histogram+HSV+RGB cleanup → color-based fallback (see [ADR-004](./adr/004-background-removal.md)) |
| `FileBookmarkService` | Platform-specific file bookmarks (iOS security-scoped, Android persistent URI) |
| `IncomingFileService` | Handles "Open In", Share sheet files, and images |
| `OriginalPdfStorage` | Stores original PDF bytes for clean saves |

## Presentation Layer (`lib/presentation/`)

UI and state management:

### Screens

| Screen | Purpose |
|--------|---------|
| `HomeScreen` | Landing page with recent files list |
| `PdfViewerScreen` | PDF viewing and editing (session-isolated) |
| `SettingsScreen` | Language and size unit preferences (Android; iOS uses Settings.bundle) |

### Key Widgets

| Widget | Purpose |
|--------|---------|
| `PdfViewer` | Core PDF viewing with zoom/scroll |
| `PdfPageList` | Virtualized page rendering |
| `PdfPageItem` | Single page with rendered image |
| `PlacedImagesLayer` | Renders placed images overlay |
| `PlacedImageOverlay` | Interactive image with resize/rotate handles |
| `PdfDropTarget` | Drag-and-drop target for placing images |
| `ImageLibrarySheet` | Draggable bottom sheet for image library (mobile) |
| `ImageList` | Sidebar image list (desktop) |
| `PageIndicator` | Current page / total pages display |
| `SizeLabel` | Image dimensions label (cm/inches) |
| `CoachMarkOverlay` | Onboarding spotlight hints |
| `ConditionalScaleRecognizer` | Gesture conflict resolver between scroll and image handles |

### Providers (Riverpod)

| Category | Providers |
|----------|-----------|
| Viewer Session | `viewerSessionsProvider`, `sessionPdfDocumentProvider(id)`, `sessionPlacedImagesProvider(id)`, `sessionEditorSelectionProvider(id)`, `sessionDocumentDirtyProvider(id)`, `sessionFileSourceProvider(id)`, `sessionPermissionRetryProvider(id)` |
| PDF Viewer | `pdfDocumentProvider`, `pdfPageCacheProvider`, `pdfPageImageProvider` |
| Editor | `placedImagesProvider`, `editorSelectionProvider`, `documentDirtyProvider`, `fileSourceProvider`, `pointerOnObjectProvider` |
| Sidebar | `sidebarImagesProvider` |
| Recent Files | `recentFilesProvider` |
| Settings | `localePreferenceProvider`, `sizeUnitPreferenceProvider`, `nativeSettingsProvider` |
| Services | `pdfSaveServiceProvider`, `pdfShareServiceProvider`, `imageToPdfServiceProvider`, `originalPdfProvider` |
| File Picker | `filePickerProvider` |
| Onboarding | `onboardingProvider` |

## Navigation

The app uses **standard Flutter Navigator** with `GlobalKey<NavigatorState>`:

```
HomeScreen (initial route)
    │
    ├─ PdfViewerScreen (pushAndRemoveUntil, keeps HomeScreen as first route)
    │   └─ back → HomeScreen
    │
    └─ SettingsScreen (push, Android only)
        └─ back → HomeScreen
```

- **`navigatorKey`** — global key for navigation from outside widget tree (incoming files)
- **`pushAndRemoveUntil`** — ensures only one PdfViewerScreen at a time
- Incoming files (PDF/image) navigate via `IncomingFileService` stream listener

## Viewer Session Architecture

Each time a PDF is opened, a **unique session** is created to isolate state:

```
ViewerSession(id, filePath, fileSource, originalImageName?)
    │
    ├─ sessionPdfDocumentProvider(id)     — document state
    ├─ sessionFileSourceProvider(id)      — save behavior
    ├─ sessionDocumentDirtyProvider(id)   — unsaved changes
    ├─ sessionPlacedImagesProvider(id)    — placed images
    ├─ sessionEditorSelectionProvider(id) — selected image
    └─ sessionPermissionRetryProvider(id) — permission state
```

- `ViewerSessionScope` (InheritedWidget) provides session ID to descendants
- `ViewerSessions` provider tracks active sessions and handles cleanup
- On session unregister, all family providers for that session are invalidated

## Data Flow Example: Opening a PDF

```
1. User taps file in HomeScreen or uses file picker
   │
2. Navigate to PdfViewerScreen with file path and FileSourceType
   │
3. ViewerSession created, registered in viewerSessionsProvider
   │
4. sessionPdfDocumentProvider.openDocument(path)
   │
5. PdfDataSource loads PDF, extracts page metadata
   │
6. PdfPageList renders visible pages via pdfPageImageProvider
   │
7. User drags image from ImageLibrarySheet to PdfDropTarget
   │
8. sessionPlacedImagesProvider.addImage() creates placement
   │
9. sessionDocumentDirtyProvider.markDirty() tracks unsaved changes
   │
10. User saves → PdfSaveService embeds images → share or overwrite
```

## Data Flow Example: Opening an Image

```
1. User opens image(s) via share sheet, file picker, or "Open In"
   │
2. Navigate to PdfViewerScreen with imagesToConvert and FileSourceType.convertedImage
   │
3. sessionPdfDocumentProvider.convertAndOpenImages(imagePaths)
   │   → State: converting(imageCount)
   │
4. ImageToPdfService converts images to A4 PDF
   │   → EXIF normalization → center & scale to fit margins
   │
5. Opens generated PDF normally
   │
6. On close, user is prompted to save (save to Documents + add to Recent Files)
```

## Key Design Decisions

### Image Placement Architecture

PlacedImagesLayer is positioned **outside** the ScrollView to prevent gesture conflicts between:
- ScrollView drag recognizer (scroll/zoom)
- Image handle pan recognizers (resize/rotate)

### File Source Tracking

`fileSourceProvider` / `sessionFileSourceProvider` determines save behavior:
- **filesApp** (iOS "Open In") → Can overwrite original
- **filePicker** / **recentFile** → Use Share Sheet
- **convertedImage** → Save to Documents, add to Recent Files

### Render Cancellation

PdfDataSource implements intelligent render cancellation:
- Each render gets unique ID
- Cancelled renders throw `RenderCancelledException`
- Prevents race conditions during fast scrolling

### Security-Scoped Bookmarks

`FileBookmarkService` handles platform-specific file access:
- **iOS**: Security-scoped bookmarks for persistent access
- **Android**: Persistable URI permissions

### EXIF Normalization

`ImageNormalizationService` bakes EXIF orientation tags into pixel data:
- Camera images often have rotation stored as metadata, not pixel rotation
- Normalization ensures correct display in viewer and PDF export
- Used by both `ImageValidationService` (library import) and `ImageToPdfService` (image-to-PDF conversion)

## Localization

60+ languages supported via Flutter's `intl` package:
- ARB files in `lib/l10n/`
- Generated classes in `lib/l10n/generated/`
- RTL support for Arabic, Hebrew, Persian
- iOS: language configurable via Settings.bundle
- Android: language configurable via in-app SettingsScreen

## Related Documentation

- [STATE_MANAGEMENT.md](./STATE_MANAGEMENT.md) — Riverpod provider details
- [PDF_EDITING.md](./PDF_EDITING.md) — Image placement, transforms, save system
- [adr/001-clean-architecture.md](./adr/001-clean-architecture.md) — Architecture decision
- [adr/003-state-management-riverpod.md](./adr/003-state-management-riverpod.md) — State management decision
- [adr/004-background-removal.md](./adr/004-background-removal.md) — Background removal decision
