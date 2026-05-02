## Why

Currently, the application has a placeholder for the Settings tab. Enriching the Settings page with theme customization, data management, map preferences, and app information improves user utility, accessibility, and retention.

## What Changes

- Replace the placeholder "Settings" text in `ContentView` with a functional, categorized `SettingsView`.
- **Appearance**: Add Dark Mode toggle and a color picker for Visited State highlights.
- **Map Preferences**: Add toggles for Map Style (Standard/Satellite) and Show State Names.
- **Data Management**: Add Export/Import functionality for user travel data.
- **About**: Display App Version and links to Source Code/GitHub.
- Persist all user preferences and handle data serialization for export/import.

## Capabilities

### New Capabilities
- `settings-screen`: A comprehensive view for user preferences, map customization, and data management.
- `data-portability`: Ability to export and import user visit data (JSON).

### Modified Capabilities
- `map-india-view`: Needs to respect new settings (visited color, state names, map style).

## Impact

- `ContentView`: Will now host `SettingsView`.
- `IndiaMapView`: Will be updated to observe and apply new map settings.
- `StateVisitManager`: Will handle data export/import logic.
- Persistence: Multiple new keys in `UserDefaults` for colors, styles, and toggles.
