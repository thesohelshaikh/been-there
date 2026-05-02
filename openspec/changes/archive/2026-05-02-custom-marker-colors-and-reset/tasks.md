## 1. Data Model and State Management

- [x] 1.1 Add `@AppStorage` keys for `capitalMarkerColor` and `cityMarkerColor` in `ContentView`.
- [x] 1.2 Pass `capitalMarkerColor` and `cityMarkerColor` as parameters to `IndiaMapView` in `ContentView`.

## 2. Map Rendering Updates

- [x] 2.1 Update `IndiaMapView` struct to accept `capitalMarkerColor` and `cityMarkerColor`.
- [x] 2.2 Update `IndiaMapView.updateUIView` to refresh `context.coordinator.parent`.
- [x] 2.3 Update `IndiaMapView.Coordinator.mapView(_:viewFor:)` to use the custom marker colors from `parent`.

## 3. Settings UI Updates

- [x] 3.1 Add color pickers for "Capital Marker Color" and "City Marker Color" in `SettingsView`.
- [x] 3.2 Implement a "Reset to Defaults" button in `SettingsView`.
- [x] 3.3 Add logic to `SettingsView` to reset all appearance-related `@AppStorage` values.

## 4. Verification

- [x] 4.1 Verify that changing marker colors in Settings immediately updates the map.
- [x] 4.2 Verify that the "Reset to Defaults" button correctly restores all colors and map style.
- [x] 4.3 Verify that marker colors are persisted across app restarts.
