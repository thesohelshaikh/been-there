## 1. Setup & Dependencies

- [x] 1.1 Add MapLibre Compose dependency to `libs.versions.toml` and `build.gradle.kts`.
- [ ] 1.2 Configure Android Manifest and iOS Info.plist if required by the SDK.

## 2. Data Migration

- [x] 2.1 Sourcing or generating a `india_states.geojson` file with state properties (IDs, Names).
- [x] 2.2 Bundle the GeoJSON file in `commonMain/composeResources/files/`.

## 3. UI Implementation

- [ ] 3.1 Replace `IndiaMap.kt` Canvas implementation with `MaplibreMap`.
- [ ] 3.2 Implement `StyleBuilder` to add the GeoJSON source and `FillLayer`.
- [ ] 3.3 Apply data-driven styling to the `FillLayer` based on the visited status.

## 4. Integration & Testing

- [ ] 4.1 Update `App.kt` to pass the necessary state data to the new `IndiaMap`.
- [ ] 4.2 Verify interactive features (pan/zoom) on both platforms.
- [ ] 4.3 Ensure state highlighting updates reactively when a city is marked.
