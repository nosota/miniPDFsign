# miniPDFSign Architecture

This document describes the high-level architecture of the miniPDFSign application.

## Overview

miniPDFSign is a mobile-first application (iOS/Android) for signing and stamping PDF documents. It follows **Clean Architecture** principles with clear separation between layers.

## Layer Structure

```
lib/
├── core/           # Shared kernel (constants, errors, theme, utils)
├── domain/         # Business logic (entities, repository interfaces)
├── data/           # Data sources, models, repository implementations, services
├── presentation/   # UI layer (screens, widgets, providers)
├── l10n/           # Localization (66 languages)
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
| `constants/` | App-wide constants (spacing, image limits, recent files limit) |
| `errors/` | Failure classes for Either/Result error handling |
| `theme/` | App theming (colors, typography, theme data) |
| `utils/` | Utility functions (date formatting, logging) |

## Domain Layer (`lib/domain/`)

Pure Dart business logic with no Flutter dependencies:

### Entities

| Entity | Purpose |
|--------|---------|
| `PdfDocumentInfo` | PDF document metadata (pages, path, protection) |
| `PdfPageInfo` | Single page metadata (dimensions) |
| `PlacedImage` | Image placed on PDF (position, size, rotation) |
| `SidebarImage` | Image in library (path, dimensions, metadata) |
| `RecentFile` | Recently opened file (path, bookmark, metadata) |

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
| `ImageValidationService` | Validates image format/size/resolution |
| `ImagePickerService` | Picks images from files or gallery |
| `FileBookmarkService` | Platform-specific file bookmarks (iOS/Android) |
| `IncomingFileService` | Handles "Open In" and Share sheet files |
| `OriginalPdfStorage` | Stores original PDF bytes for clean saves |

## Presentation Layer (`lib/presentation/`)

UI and state management:

### Screens

| Screen | Purpose |
|--------|---------|
| `HomeScreen` | Landing page with recent files |
| `PdfViewerScreen` | PDF viewing and editing |

### Key Widgets

| Widget | Purpose |
|--------|---------|
| `PdfViewer` | Core PDF viewing with zoom/scroll |
| `PdfPageList` | Virtualized page rendering |
| `PlacedImagesLayer` | Renders placed images overlay |
| `PlacedImageWidget` | Interactive image with resize/rotate handles |
| `ImageLibrarySheet` | Draggable bottom sheet for image library |
| `CoachMarkOverlay` | Onboarding spotlight hints |

### Providers (Riverpod)

| Category | Providers |
|----------|-----------|
| PDF Viewer | `pdfDocumentProvider`, `pdfPageCacheProvider`, `visiblePagesProvider` |
| Editor | `placedImagesProvider`, `editorSelectionProvider`, `documentDirtyProvider` |
| Sidebar | `sidebarImagesProvider` |
| Recent Files | `recentFilesProvider` |
| Settings | `localePreferenceProvider`, `sizeUnitPreferenceProvider` |
| Onboarding | `onboardingProvider` |

## Data Flow Example: Opening a PDF

```
1. User taps file in HomeScreen or uses file picker
   │
2. fileSourceProvider tracks source (affects save behavior)
   │
3. Navigate to PdfViewerScreen with file path
   │
4. pdfDocumentProvider.openDocument(path)
   │
5. PdfDataSource loads PDF, extracts page metadata
   │
6. PdfPageList renders visible pages via pdfPageImageProvider
   │
7. User drags image from ImageLibrarySheet to PdfDropTarget
   │
8. placedImagesProvider.addImage() creates placement
   │
9. documentDirtyProvider.markDirty() tracks unsaved changes
   │
10. User saves → PdfSaveService embeds images → share or overwrite
```

## Key Design Decisions

### Image Placement Architecture

PlacedImagesLayer is positioned **outside** the ScrollView to prevent gesture conflicts between:
- ScrollView drag recognizer (scroll/zoom)
- Image handle pan recognizers (resize/rotate)

### File Source Tracking

`fileSourceProvider` determines save behavior:
- **filesApp** (iOS "Open In") → Can overwrite original
- **filePicker** / **recentFile** → Use Share Sheet

### Render Cancellation

PdfDataSource implements intelligent render cancellation:
- Each render gets unique ID
- Cancelled renders throw `RenderCancelledException`
- Prevents race conditions during fast scrolling

### Security-Scoped Bookmarks

`FileBookmarkService` handles platform-specific file access:
- **iOS**: Security-scoped bookmarks for persistent access
- **Android**: Persistable URI permissions

## Localization

66 languages supported via Flutter's `intl` package:
- ARB files in `lib/l10n/`
- Generated classes in `lib/l10n/generated/`
- RTL support for Arabic, Hebrew, Persian

## Related Documentation

- [adr/001-clean-architecture.md](./adr/001-clean-architecture.md) - Architecture decision
- [adr/003-state-management-riverpod.md](./adr/003-state-management-riverpod.md) - State management
