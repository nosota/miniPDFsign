# miniPDFSign

A cross-platform mobile application for signing and stamping PDF documents. Built with Flutter for iOS and Android.

## Features

- **PDF Viewing** — Smooth continuous scrolling with pinch-to-zoom
- **Image Placement** — Drag and drop signatures, stamps, and seals onto PDF pages
- **Transform Controls** — Move, resize, and rotate placed images with intuitive gestures
- **Background Removal** — Automatic detection and removal of uniform backgrounds (white paper, etc.)
- **Image Library** — Reusable collection of signatures and stamps synced across documents
- **Camera Capture** — Take photos directly and add to library
- **Multi-language** — 60+ languages including RTL support (Arabic, Hebrew, Persian)
- **Save & Share** — Export edited PDFs with embedded images

## Screenshots

<!-- Add screenshots here -->
<!-- ![Home Screen](docs/screenshots/home.png) -->
<!-- ![PDF Editor](docs/screenshots/editor.png) -->

## Requirements

- **iOS**: 13.0+
- **Android**: API 24+ (Android 7.0)
- **Flutter**: 3.24.0+
- **Dart**: 3.5.0+

## Getting Started

### Prerequisites

1. Install [Flutter](https://docs.flutter.dev/get-started/install) (3.24.0 or later)
2. Install Xcode (for iOS) or Android Studio (for Android)
3. Clone the repository:

```bash
git clone https://github.com/ivanvaganov/miniPDFSign.git
cd miniPDFSign
```

### Installation

```bash
# Get dependencies
flutter pub get

# Generate code (Riverpod, Isar, Freezed)
dart run build_runner build --delete-conflicting-outputs

# Generate localizations
flutter gen-l10n
```

### Running

```bash
# iOS Simulator
flutter run -d ios

# Android Emulator
flutter run -d android

# Specific device
flutter devices
flutter run -d <device_id>
```

### Building

```bash
# iOS (requires Apple Developer account for device builds)
flutter build ios --release

# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release
```

## Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/           # Shared utilities, constants, errors
├── domain/         # Business logic (entities, repositories, use cases)
├── data/           # Data layer (services, models, repository implementations)
├── presentation/   # UI layer (screens, widgets, providers)
└── l10n/           # Localization files (60+ languages)
```

### Key Technologies

| Layer | Technology |
|-------|------------|
| State Management | [Riverpod](https://riverpod.dev/) with code generation |
| PDF Viewing | [pdfx](https://pub.dev/packages/pdfx) |
| PDF Editing | [Syncfusion Flutter PDF](https://pub.dev/packages/syncfusion_flutter_pdf) |
| Local Storage | [Isar](https://isar.dev/) |
| Code Generation | Freezed, Riverpod Generator, Isar Generator |

### Background Removal

The app uses platform-specific ML APIs for intelligent background removal:

- **iOS 17+**: Vision framework (`VNGenerateForegroundInstanceMaskRequest`)
- **Android API 24+**: ML Kit Subject Segmentation
- **Fallback**: Color-based removal for uniform backgrounds

See [ADR-004](docs/adr/004-background-removal.md) for design decisions.

## Localization

Supports 60+ languages with full RTL support:

| Region | Languages |
|--------|-----------|
| Europe | English, German, French, Spanish, Italian, Portuguese, Dutch, Polish, Russian, Ukrainian, and more |
| Asia | Chinese (Simplified/Traditional), Japanese, Korean, Hindi, Thai, Vietnamese, and more |
| Middle East | Arabic, Hebrew, Persian, Turkish |
| Others | Filipino, Indonesian, Malay, Swahili |

To add a new language:

1. Create `lib/l10n/app_<locale>.arb`
2. Copy keys from `app_en.arb`
3. Translate all strings
4. Run `flutter gen-l10n`

## Documentation

- [Architecture Overview](docs/ARCHITECTURE.md)
- [State Management](docs/STATE_MANAGEMENT.md)
- [PDF Editing System](docs/PDF_EDITING.md)
- [Architecture Decision Records](docs/adr/README.md)

## Project Structure

```
miniPDFSign/
├── android/                 # Android native code
├── ios/                     # iOS native code
├── lib/                     # Dart/Flutter source
│   ├── core/               # Shared kernel
│   ├── data/               # Data layer
│   ├── domain/             # Domain layer
│   ├── presentation/       # UI layer
│   └── l10n/               # Localizations
├── docs/                    # Documentation
│   └── adr/                # Architecture Decision Records
├── test/                    # Unit and widget tests
└── pubspec.yaml            # Dependencies
```

## Development

### Code Generation

After modifying files with `@riverpod`, `@freezed`, or `@collection` annotations:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Or watch for changes:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Linting

```bash
flutter analyze
```

### Testing

```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please follow [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.

## License

This project is proprietary software. All rights reserved.

<!-- Or if open source:
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
-->

## Acknowledgments

- [Flutter](https://flutter.dev/) — UI framework
- [Riverpod](https://riverpod.dev/) — State management
- [Syncfusion](https://www.syncfusion.com/) — PDF library
- [ML Kit](https://developers.google.com/ml-kit) — Android ML APIs
- [Vision Framework](https://developer.apple.com/documentation/vision) — iOS ML APIs

---

Made with Flutter
