## 1. Data Layer & Persistence

- [x] 1.1 Create `CityVisitManager.swift` to handle storage of visited cities (with coordinates).
- [x] 1.2 Implement migration logic in `CityVisitManager` to convert legacy `visitedStates` to city visits (capitals).
- [x] 1.3 Update `StateVisitManager` to derive state status from `CityVisitManager` based on capital city presence.
- [x] 1.4 Update `StatsViewModel` to reflect the new city-based state visitation logic.

## 2. City Selection UI

- [x] 2.1 Create `CitySelectionSheet.swift` with a search interface.
- [x] 2.2 Integrate `MKLocalSearch` into `CitySelectionSheet` for city discovery and coordinate retrieval.
- [x] 2.3 Implement toggle logic for marking cities as visited in the UI.

## 3. Map Interaction & Integration

- [x] 3.1 Update `IndiaMapView` to presentation a sheet on state tap instead of toggling state status.
- [x] 3.2 Update `ContentView` to manage the sheet state and provide selected state context.
- [x] 3.3 Implement `MKAnnotation` rendering in `IndiaMapView` for capitals and visited cities.
- [x] 3.4 Add custom styling for annotations (Star for capitals, Dot for cities) with color coding for visited status.
- [x] 3.5 Ensure `IndiaMapView` correctly renders green fill based on derived state status from `CityVisitManager`.

## 4. Verification

- [x] 4.1 Update `StatsViewModelTests` to use the new city-based logic.
- [x] 4.2 Add unit tests for `CityVisitManager` migration and persistence.
- [x] 4.3 Verify MapKit Search functionality and annotation placement.
