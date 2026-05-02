## Context

The Settings page is being expanded from a simple theme toggle to a full configuration hub. This requires updating the UI, persistence layer, and the map rendering logic.

## Goals / Non-Goals

**Goals:**
- Implement a multi-section `SettingsView` (Appearance, Map, Data, About).
- Add `ColorPicker` for visited state highlights.
- Implement JSON serialization/deserialization for Export/Import.
- Update `IndiaMapView` to react to map style and label toggles.
- Link to GitHub repository.

**Non-Goals:**
- Cloud-based sync (keeping it local-first via file import/export).

## Decisions

- **Color Persistence**: Store hex strings in `UserDefaults` to persist the selected visited color.
- **Export/Import**: Use `Data` and `JSONEncoder/Decoder` on the `StateVisitManager` model. Use `fileExporter` and `fileImporter` modifiers in SwiftUI.
- **Map Updates**: `IndiaMapView` (the `UIViewRepresentable`) will need to re-render overlays or update the `MKMapView` configuration when its `Settings` dependencies change.
- **Version Info**: Use `Bundle.main` to fetch the version and build number dynamically.

## Risks / Trade-offs

- **[Risk]** Map Performance: Re-rendering all GeoJSON overlays when a color changes might be heavy. → **Mitigation**: Update overlay renderer properties directly if possible instead of removing/re-adding all overlays.
- **[Risk]** Data Corruption on Import: Malformed JSON could crash the app. → **Mitigation**: Use robust error handling and validation during `JSONDecoder` decoding.
