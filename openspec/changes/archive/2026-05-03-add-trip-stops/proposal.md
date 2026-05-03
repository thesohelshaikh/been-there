## Why

Users often take trips with multiple stops between their origin and destination. Allowing users to record these intermediate stops provides a more accurate and detailed record of their journeys.

## What Changes

- **BREAKING**: Update the `Trip` data model to support a list of intermediate stops.
- Update `AddTripSheet` to allow users to add, remove, and reorder multiple stops between origin and destination.
- Update `IndiaMapView` to render polylines that connect the origin, all intermediate stops, and the destination in sequence.
- Update `TripsView` to show stop information in the trip list.

## Capabilities

### New Capabilities
- None (Building on existing ones).

### Modified Capabilities
- `trip-manager`: Update requirements to handle multiple stops in a trip.
- `trips-tab`: Update UI requirements for managing trips with stops.
- `map-india-view`: Update visualization requirements to handle multi-segment polylines.

## Impact

- **Data Model**: `Trip` struct will now include `var stops: [City]`.
- **UI**: `AddTripSheet` will need a dynamic list or section for stops.
- **Map**: Rendering logic in `IndiaMapView` will transition from a single `MKPolyline` with 2 coordinates to one with $2 + n$ coordinates.
- **Testing**: `TripManagerTests` will need updates to verify stop persistence.
