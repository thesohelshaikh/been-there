## Context

Deleting a trip currently happens immediately upon swiping. We need to add an alert to confirm the action.

## Goals / Non-Goals

**Goals:**
- Present a standard SwiftUI alert before deleting a trip.
- Allow users to cancel the deletion.

## Decisions

### 1. Intercepting Deletion
- **Decision**: Remove `.onDelete` and use `.swipeActions(edge: .trailing)` with a delete button.
- **Rationale**: `.onDelete` is designed for immediate removal. Manual swipe actions give more control over the flow.

### 2. State Management
- **Decision**: Add `@State private var tripToDelete: Trip?` and `@State private var showingDeleteAlert = false`.
- **Rationale**: Standard way to handle alerts related to a specific item.

## Risks / Trade-offs

- **[Risk] Slight friction** → **Mitigation**: This is acceptable for destructive actions.
