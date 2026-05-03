## Context

Basic persistence is implemented using `UserDefaults` and `JSONEncoder`/`JSONDecoder`. We need to ensure this is reliable and integrated into the app's maintenance features.

## Goals / Non-Goals

**Goals:**
- Ensure every change to trips is saved.
- Add error logging for encoding/decoding failures.
- Provide a way to clear all trips in Settings.

**Non-Goals:**
- Migration to CoreData or SwiftData (for now, `UserDefaults` is sufficient for this simple app).

## Decisions

### 1. Robustness in `TripManager`
- **Decision**: Wrap `save()` and `load()` logic in `do-catch` blocks and use `print` for debugging.
- **Rationale**: Currently, failures are silent. Visibility into failures helps debug persistence issues.

### 2. Clear All Trips
- **Decision**: Add `clearAllTrips()` to `TripManager`.
- **Rationale**: Necessary for testing and for users who want to start over.

### 3. Integration with Settings
- **Decision**: Update `SettingsView` to accept `tripManager` and add a button for "Clear All Trips" under a confirmation alert.
- **Rationale**: Centralizes all data management in one screen.

## Risks / Trade-offs

- **[Risk] Data Loss** → **Mitigation**: Use confirmation alerts for destructive actions.
