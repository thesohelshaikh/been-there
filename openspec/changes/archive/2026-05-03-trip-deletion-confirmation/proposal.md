## Why

Accidental trip deletion can lead to data loss and user frustration. Adding a confirmation step ensures that users intended to delete a trip before the action is finalized.

## What Changes

- Update `TripsView` to intercept deletion and ask for confirmation.
- Replace default `.onDelete` with custom trailing swipe actions that trigger an alert.

## Capabilities

### Modified Capabilities
- `trips-tab`: Update the deletion workflow to include a confirmation step.

## Impact

- **UI**: `TripsView` will have a new alert state.
- **UX**: Improved safety for data management.
