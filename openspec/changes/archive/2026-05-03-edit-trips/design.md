## Context

The "Road Trips" feature allows recording journeys. Currently, journeys can only be added or deleted. We need to implement an "Edit" flow.

## Goals / Non-Goals

**Goals:**
- Enable editing of trip metadata: origin, destination, stops, transport mode, and date.
- Reuse `AddTripSheet` for editing.
- Maintain data integrity and persistence.

**Non-Goals:**
- Partial updates (e.g., only updating transport mode). The entire `Trip` object will be replaced.

## Decisions

### 1. Trip Updating Logic
- **Decision**: Add `updateTrip(_ trip: Trip)` to `TripManager`.
- **Rationale**: Since `Trip` is `Identifiable` (using UUID), we can find and replace the existing trip in the array. Sorting should be re-applied to maintain order.

### 2. UI: Reusing `AddTripSheet`
- **Decision**: Add an optional `tripToEdit: Trip?` to `AddTripSheet`'s initializer.
- **Rationale**: If `tripToEdit` is provided, initialize the state variables with its values and change the navigation title to "Edit Trip". The "Add" button will change to "Save".

### 3. UI: Triggering Edit from `TripsView`
- **Decision**: Add a button or tap gesture to each `TripRow` (or a swipe action) to trigger the edit sheet. A swipe action is idiomatic for lists.
- **Rationale**: Keeps the list clean while providing easy access to editing.

## Risks / Trade-offs

- **[Risk] State synchronization** → **Mitigation**: Using `@ObservedObject` for `TripManager` ensures the list updates immediately when the trip is saved.
