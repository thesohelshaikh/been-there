## Why

Users want to track their journeys between cities, not just the cities they've visited. Adding a road trips feature allows users to visualize their travels across India using various modes of transport, providing a more comprehensive travel diary.

## What Changes

- Replace the placeholder "Places" tab with a functional "Trips" tab.
- Implement a system to record trips between cities.
- Store trip details: origin, destination, transport mode (plane, train, car, bike), date, and time.
- Visualize trips on the interactive map of India as lines or paths between cities.

## Capabilities

### New Capabilities
- `trip-manager`: Persistence and management of trip data.
- `trips-tab`: User interface for viewing, adding, and deleting trips.

### Modified Capabilities
- `map-india-view`: Update the map to render trip paths between cities and toggle trip visibility.
- `places-list`: This capability is being retired/replaced by `trips-tab`.

## Impact

- **UI**: `ContentView` will be updated to replace the "Coming Soon!" text with `TripsView`.
- **Logic**: A new `TripManager` class will handle CRUD operations for trips.
- **Map**: `IndiaMapView` and its `MKMapView` delegate will be updated to handle polyline overlays for trips.
- **Data**: New data model `Trip` and persistence key in `UserDefaults`.
