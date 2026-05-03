## 1. Data Models & Persistence

- [x] 1.1 Define `TransportMode` enum with Plane, Train, Car, Bike cases
- [x] 1.2 Implement `Trip` struct conforming to `Codable` and `Identifiable`
- [x] 1.3 Create `TripManager` class for managing and persisting trips in `UserDefaults`
- [x] 1.4 Add unit tests for `TripManager` CRUD operations

## 2. Trip Management UI

- [x] 2.1 Create `AddTripSheet` view for searching cities and adding trip details
- [x] 2.2 Implement city search utility (reusable `MKLocalSearch` logic)
- [x] 2.3 Create `TripsView` to list existing trips with transport mode icons and dates
- [x] 2.4 Add delete functionality to `TripsView`

## 3. Map Visualization

- [x] 3.1 Update `IndiaMapView` to accept `TripManager` as an environment object or state object
- [x] 3.2 Implement `MKPolyline` rendering for trips in `IndiaMapView` delegate
- [x] 3.3 Add "Show Trips" toggle in `SettingsView` (with corresponding `AppStorage`)
- [x] 3.4 Ensure map updates when a trip is added or removed

## 4. App Integration & Cleanup

- [x] 4.1 Replace "Places" placeholder in `ContentView` with `TripsView`
- [x] 4.2 Update tab bar icons and labels in `ContentView`
- [x] 4.3 Verify all transport modes display correct SF Symbols
- [x] 4.4 Final walkthrough and bug fixes
