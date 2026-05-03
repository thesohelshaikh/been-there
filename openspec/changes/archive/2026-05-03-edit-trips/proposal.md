## Why

Currently, once a trip is recorded, it cannot be modified. If a user makes a mistake or their travel plans change, they have to delete the trip and recreate it from scratch. Adding editing capabilities improves the user experience and data accuracy.

## What Changes

- Update `TripManager` to support updating an existing trip.
- Modify `AddTripSheet` to function as an "Edit Trip" sheet when provided with an existing trip.
- Update `TripsView` to allow users to trigger the editing flow for a specific trip.

## Capabilities

### New Capabilities
- None.

### Modified Capabilities
- `trip-manager`: Add requirement for updating existing trips.
- `trips-tab`: Add requirement for editing trips from the list.

## Impact

- **Logic**: `TripManager` will need an `updateTrip` method.
- **UI**: `AddTripSheet` will need conditional logic for "Add" vs "Edit" modes.
- **UI**: `TripsView` will need to track which trip is being edited and present the sheet.
