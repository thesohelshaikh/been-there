## 1. UI Implementation (SettingsView)

- [x] 1.1 Create `BeenThere/UI/SettingsView.swift` with grouped sections (Appearance, Map, Data, About).
- [x] 1.2 Implement Dark Mode toggle and Color Picker for visited states.
- [x] 1.3 Implement Map Style picker and "Show Labels" toggle.
- [x] 1.4 Add "About" section with version string and GitHub link.
- [x] 1.5 Replace placeholder in `ContentView.swift` with new `SettingsView`.

## 2. Map & Logic Updates

- [x] 2.1 Update `IndiaMapView` to observe map-related settings (style, color, labels).
- [x] 2.2 Add export/import methods to `StateVisitManager`.
- [x] 2.3 Implement `fileExporter` and `fileImporter` logic in `SettingsView`.

## 3. Global State & Persistence

- [x] 3.1 Use `@AppStorage` for all new settings in `SettingsView` and `BeenThereApp`.
- [x] 3.2 Ensure `BeenThereApp` applies the theme globally.

## 4. Verification

- [x] 4.1 Verify map style and color updates reflect immediately on the map.
- [x] 4.2 Test export/import with a sample JSON file.
- [x] 4.3 Check version info matches the project settings.
