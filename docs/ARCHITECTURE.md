# PDFSign Architecture

This document describes the high-level architecture of the PDFSign application.

## Overview

PDFSign is a macOS application for signing and stamping PDF documents. It follows **Clean Architecture** principles with clear separation between layers.

## Layer Structure

```
lib/
├── core/           # Shared kernel (errors, utils, constants, platform)
├── domain/         # Business logic (entities, repositories interfaces)
├── data/           # Data sources and repository implementations
├── presentation/   # UI layer (screens, widgets, providers)
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
| `constants/` | App-wide constants (spacing, radii, sidebar) |
| `errors/` | Failure classes for error handling |
| `platform/` | Native platform channels (macOS integration) |
| `theme/` | App theming (colors, typography, shadows) |
| `utils/` | Utility functions (date formatting, platform utils) |
| `window/` | Multi-window management |
| `router/` | Navigation with go_router |

## Domain Layer (`lib/domain/`)

Pure Dart business logic with no Flutter dependencies:

| Directory | Purpose |
|-----------|---------|
| `entities/` | Business objects (PlacedImage, SidebarImage, RecentFile) |
| `repositories/` | Abstract repository interfaces |

## Data Layer (`lib/data/`)

Implementation of data operations:

| Directory | Purpose |
|-----------|---------|
| `datasources/` | Local and remote data sources |
| `models/` | Data transfer objects with serialization |
| `repositories/` | Repository implementations |
| `services/` | Business services (PDF save, image storage) |

## Presentation Layer (`lib/presentation/`)

UI and state management:

| Directory | Purpose |
|-----------|---------|
| `apps/` | Root app widgets (WelcomeApp, PdfViewerApp, SettingsApp) |
| `screens/` | Screen widgets organized by feature |
| `widgets/` | Shared widgets (menus, dialogs) |
| `providers/` | Riverpod state management |

## Key Components

### Multi-Window System

PDFSign uses `desktop_multi_window` for multi-window support:
- **Welcome Window** (main) - File picker and recent files
- **PDF Viewer Windows** (sub) - One per open document
- **Settings Window** (sub, singleton) - App preferences

See [MULTI_WINDOW.md](./MULTI_WINDOW.md) for details.

### Platform Channels

Native macOS integration via method channels:
- Toolbar with Share button
- File open handling from Finder
- Window lifecycle management

See [PLATFORM_CHANNELS.md](./PLATFORM_CHANNELS.md) for details.

### State Management

Riverpod is used for all state management:
- `StateNotifierProvider` for complex state
- `StateProvider` for simple UI state
- `FutureProvider` for async operations

## Data Flow Example: Opening a PDF

```
1. User clicks file in Welcome Screen
   │
2. WelcomeScreen calls WindowManagerService.createPdfWindow(path)
   │
3. WindowManagerService creates new Flutter window
   │
4. PdfViewerApp initializes with file path
   │
5. pdfDocumentProvider loads PDF via PdfDocumentRepository
   │
6. PdfViewer renders pages from pdfPageCacheProvider
   │
7. User can drag images from sidebar to PDF
   │
8. placedImagesProvider tracks placed images
   │
9. User saves → PdfSaveService creates modified PDF
```

## Testing Strategy

| Test Type | Location | Coverage Target |
|-----------|----------|-----------------|
| Unit tests | `test/` | Domain, Data layers (80%+) |
| Widget tests | `test/` | All public widgets |
| Integration tests | `integration_test/` | Critical user flows |

## Related Documentation

- [MULTI_WINDOW.md](./MULTI_WINDOW.md) - Multi-window architecture
- [PLATFORM_CHANNELS.md](./PLATFORM_CHANNELS.md) - Native integration
- [adr/](./adr/) - Architecture Decision Records
