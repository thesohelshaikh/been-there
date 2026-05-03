## 1. Data Model & Persistence

- [x] 1.1 Add `stops: [City]` field to `Trip` struct (with default empty array)
- [x] 1.2 Update `TripManagerTests` to verify trips with multiple stops can be saved and loaded

## 2. User Interface Enhancements

- [x] 2.1 Refactor `AddTripSheet` to support a dynamic list of intermediate stops
- [x] 2.2 Add "Add Stop" functionality to `AddTripSheet` with city search integration
- [x] 2.3 Add removal functionality for intermediate stops in `AddTripSheet`
- [x] 2.4 Update `TripRow` in `TripsView` to indicate the number of stops

## 3. Map Visualization

- [x] 3.1 Update `IndiaMapView.loadTrips` to construct `MKPolyline` using origin, stops, and destination
- [x] 3.2 Verify multi-segment polyline rendering on the map
