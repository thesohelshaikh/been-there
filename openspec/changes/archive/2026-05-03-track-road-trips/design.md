## Context

The application currently tracks visited states and cities in India. It uses `MKMapView` to display these visited regions. The goal is to extend this to track journeys (trips) between cities and visualize them on the same map.

## Goals / Non-Goals

**Goals:**
- Provide a `Trip` data model and persistence.
- Implement a `TripsView` to list and manage trips.
- Integrate trip visualization (polylines) into `IndiaMapView`.
- Support multiple transport modes: Plane, Train, Car, Bike.

**Non-Goals:**
- Real-time navigation or route planning.
- Complex routing (following roads) - straight lines between cities are sufficient for now.
- Editing existing trips (deletion and addition only).

## Decisions

### 1. Data Model: `Trip`
- **Rationale**: A dedicated struct `Trip` will store all necessary metadata.
- **Attributes**: `id` (UUID), `origin` (`City`), `destination` (`City`), `transportMode` (`TransportMode` enum), `date` (`Date`).
- **Persistence**: Store as a JSON-encoded array in `UserDefaults` via `TripManager`, maintaining consistency with `CityVisitManager`.

### 2. Transport Modes
- **Enum**: `TransportMode` with cases `.plane`, `.train`, `.car`, `.bike`.
- **Icons**: Use SF Symbols for each mode (e.g., `airplane`, `train.side.front.car`, `car.fill`, `bicycle`).

### 3. Map Visualization
- **Implementation**: Use `MKPolyline` to draw lines between `origin.coordinate` and `destination.coordinate`.
- **Styling**: All trips will use a consistent style initially (e.g., dashed blue line) to distinguish from state boundaries. We can potentially vary color by transport mode in the future.
- **Coordinate Handling**: Since `City` already contains coordinates, we don't need additional lookups during rendering.

### 4. City Selection for Trips
- **Approach**: Reuse `MKLocalSearch` to find cities for origin and destination.
- **Integration**: `TripsView` will have an "Add Trip" sheet with search bars for origin and destination.

## Risks / Trade-offs

- **[Risk] Data inconsistency if a city is deleted** → **Mitigation**: Trips store their own copies of `City` data (id, name, coordinate), making them independent of the "visited cities" list.
- **[Risk] Map clutter with many trips** → **Mitigation**: Add a toggle in Settings (or a map layer control) to show/hide trips.
- **[Risk] Straight lines for land transport** → **Mitigation**: Accept as a "Non-Goal" for simplicity, as actual road routing requires external APIs and more complexity.
