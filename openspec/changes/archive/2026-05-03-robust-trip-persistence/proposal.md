## Why

Persistence is a core requirement for user data. While basic persistence is implemented, we need to ensure it is robust, observable, and integrated into the app's overall data management strategy (e.g., reset and export/import).

## What Changes

- Add logging and error handling to `TripManager` persistence methods.
- Integrate `TripManager` with `SettingsView` for data management.
- Add a "Clear All Trips" action in `SettingsView`.
- (Optional) Include trips in the app's export/import functionality.

## Capabilities

### New Capabilities
- None.

### Modified Capabilities
- `trip-manager`: Add robust error handling and clear-all functionality.
- `settings-screen`: Integrate trip data management actions.

## Impact

- **Persistence**: `TripManager` will have more reliable save/load cycles.
- **UI**: `SettingsView` will include new sections or buttons for managing trip data.
- **UX**: Users will have more control over their stored trips.
