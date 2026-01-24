# ADR-001: Clean Architecture

**Status:** Accepted
**Date:** 2024

## Context

We need to establish an architecture for PDFSign that:
- Supports testability
- Allows easy maintenance and modification
- Separates concerns clearly
- Keeps business logic independent of Flutter framework

## Decision

Adopt **Clean Architecture** with three main layers:

1. **Domain Layer** - Pure Dart business logic
2. **Data Layer** - Repository implementations, data sources
3. **Presentation Layer** - Flutter UI, state management

### Layer Rules

| Layer | Can Depend On | Cannot Depend On |
|-------|---------------|------------------|
| Domain | Nothing (pure Dart) | Data, Presentation, Flutter |
| Data | Domain | Presentation |
| Presentation | Domain | Data (uses interfaces) |

### Directory Structure

```
lib/
├── core/           # Shared utilities (all layers can use)
├── domain/         # Entities, repository interfaces
├── data/           # Implementations, data sources, models
└── presentation/   # Screens, widgets, providers
```

## Consequences

### Positive

- **Testability**: Domain and Data layers can be unit tested without Flutter
- **Flexibility**: Easy to swap implementations (e.g., different PDF library)
- **Maintainability**: Clear separation makes code easier to understand
- **Independence**: Business logic doesn't depend on framework

### Negative

- **Boilerplate**: More files and classes needed
- **Learning curve**: Team needs to understand architecture
- **Over-engineering risk**: Simple features may feel heavyweight

## Alternatives Considered

1. **MVC/MVVM without layers** - Simpler but mixes concerns
2. **Feature-first structure** - Good for large teams, overkill for us
3. **No architecture** - Fast initially, unmaintainable long-term

## References

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
