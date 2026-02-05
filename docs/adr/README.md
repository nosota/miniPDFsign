# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) for the miniPDFSign project.

## What is an ADR?

An ADR is a document that captures an important architectural decision made along with its context and consequences.

## Index

| ADR | Title | Status |
|-----|-------|--------|
| [001](./001-clean-architecture.md) | Clean Architecture | Accepted |
| [003](./003-state-management-riverpod.md) | State Management with Riverpod | Accepted |
| [004](./004-background-removal.md) | Background Removal for Images | Accepted |

## Template

When adding a new ADR, use this template:

```markdown
# ADR-XXX: Title

**Status:** Proposed | Accepted | Deprecated | Superseded
**Date:** YYYY-MM-DD

## Context

What is the issue that we're seeing that is motivating this decision?

## Decision

What is the change that we're proposing and/or doing?

## Consequences

What becomes easier or more difficult to do because of this change?

## Alternatives Considered

What other options were evaluated?

## References

Links to relevant resources.
```

## Statuses

- **Proposed** - Under discussion
- **Accepted** - Implemented and in use
- **Deprecated** - No longer recommended
- **Superseded** - Replaced by another ADR
