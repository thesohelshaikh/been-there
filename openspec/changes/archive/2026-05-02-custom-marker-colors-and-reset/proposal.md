## Why

Allow users to personalize their travel map by customizing marker colors for capital cities and other visited cities. This improves visibility against different map styles and provides a way to quickly restore default appearance settings.

## What Changes

- Add color pickers in Settings for:
    - Capital City Marker Color
    - Regular City Marker Color
- Add a "Reset to Defaults" button in Settings to restore:
    - Visited State Color
    - Capital City Marker Color
    - Regular City Marker Color
- Update map rendering logic to use these custom colors dynamically.

## Capabilities

### New Capabilities
<!-- None -->

### Modified Capabilities
- `settings-screen`: Add UI controls for marker colors and the reset functionality.
- `map-india-view`: Update annotation rendering to use user-defined marker colors.

## Impact

- `SettingsView`: UI and persistence logic updates.
- `IndiaMapView`: Rendering logic updates in the Coordinator.
- `UserDefaults`: New keys for marker colors.
