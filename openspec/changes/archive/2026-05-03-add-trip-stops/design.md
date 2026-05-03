## Context

The current `Trip` model only supports a direct path between an origin and a destination. Visualization is handled by a single `MKPolyline` with two points. Users want to add intermediate stops to their journeys.

## Goals / Non-Goals

**Goals:**
- Extend `Trip` to include an array of stops.
- Update `AddTripSheet` UI to manage a list of stops.
- Update `IndiaMapView` to render a continuous path through all points.
- Support up to 10 intermediate stops (arbitrary limit for UI sanity).

**Non-Goals:**
- Individual transport modes for each segment of a trip (the entire trip shares one mode for now).
- Time/date for individual stops (the trip has one overall date).

## Decisions

### 1. Data Model Extension
- **Update**: Add `var stops: [City] = []` to `Trip`.
- **Rationale**: Keeps the structure simple while allowing an arbitrary number of points.

### 2. UI: `AddTripSheet` Evolution
- **Component**: Use a `Section` in the `Form` for "Intermediate Stops".
- **Interaction**: Add an "Add Stop" button. Each stop will have its own search field and a delete button.
- **Ordering**: For the first iteration, we will append stops in the order they are added. Reordering can be a future enhancement if requested.

### 3. Map Visualization
- **Logic**: Construct `MKPolyline` using a combined array of coordinates: `[origin.coordinate] + stops.map { $0.coordinate } + [destination.coordinate]`.
- **Renderer**: The existing `TripPolyline` renderer will work without changes as it already handles `MKPolyline` overlays.

## Risks / Trade-offs

- **[Risk] Data Migration** → **Mitigation**: Since this is a new feature and `stops` is an optional array (or defaults to empty), existing JSON data should decode correctly if the new field is treated as optional during decoding or if a default value is provided.
- **[Risk] UI Complexity** → **Mitigation**: Use a simple list-based approach for stops within the existing `Form`.
