## Why

The current city search in `AddTripSheet` is described as "jarry" and "not native". This is likely due to immediate API calls on every keystroke, nested scrolling views (List inside Form), and sudden layout shifts when results appear.

## What Changes

- Implement debouncing for the search query to reduce API calls and flickering.
- Replace the nested `List` within `Form` with a more native-feeling suggestion UI (e.g., using `View` overlays or a dedicated search flow).
- Use `MKLocalSearchCompleter` for faster and more relevant city suggestions.
- Improve the visual feedback during search (smoother transitions).

## Capabilities

### Modified Capabilities
- `trips-tab`: Update the "Add Trip" and "Edit Trip" search experience to be smoother and more native.

## Impact

- **UI**: `AddTripSheet` will be significantly refactored for its search logic and presentation.
- **Performance**: Reduced network/API overhead due to debouncing.
- **UX**: A much smoother, more standard iOS search experience.
