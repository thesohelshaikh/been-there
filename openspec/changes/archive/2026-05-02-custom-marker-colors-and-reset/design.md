## Context

The application currently allows users to customize the "Visited State Color" and toggle between map styles. However, the map markers (for capital cities and other visited cities) use hardcoded colors. Users have requested the ability to customize these marker colors for better visibility and personalization.

## Goals / Non-Goals

**Goals:**
- Add settings to customize marker colors for capital cities and other cities.
- Implement a "Reset to Defaults" functionality for all appearance-related settings.
- Ensure map markers update immediately when settings are changed.

**Non-Goals:**
- Custom marker icons or shapes (stick to circles for now).
- Per-city color customization.

## Decisions

### 1. Persistence and Data Model
Use `@AppStorage` in `ContentView` and `SettingsView` to persist the new color settings as hex strings.
- `capitalMarkerColor`: Default `"FFD700"` (Yellow)
- `cityMarkerColor`: Default `"34C759"` (Green)

### 2. Map Update Strategy
Follow the pattern established for `visitedStateColor`:
- Pass `capitalMarkerColor` and `cityMarkerColor` as constant parameters from `ContentView` to `IndiaMapView`.
- In `IndiaMapView.updateUIView`, update `context.coordinator.parent = self` to ensure the coordinator has access to the latest color values.
- The `Coordinator` will use these values in `viewFor annotation`.

### 3. Reset Functionality
Add a "Reset to Defaults" button in `SettingsView`. When tapped, it will:
- Set `visitedStateColor` to `"2D6A4F"`.
- Set `capitalMarkerColor` to `"FFD700"`.
- Set `cityMarkerColor` to `"34C759"`.
- Set `mapStyle` to `"standard"`.

## Risks / Trade-offs

- [Risk] Users might choose colors that collide with the map background or each other. → [Mitigation] The "Reset to Defaults" button provides an easy way to recover.
- [Risk] Passing more parameters to `IndiaMapView` might clutter the initializer. → [Mitigation] This is necessary for SwiftUI to track dependencies correctly in `UIViewRepresentable`.
