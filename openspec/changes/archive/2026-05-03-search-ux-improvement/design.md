## Context

The current `AddTripSheet` search logic triggers `MKLocalSearch` immediately upon query change and displays results in a nested `List` within a `Form`. This leads to poor performance and layout issues.

## Goals / Non-Goals

**Goals:**
- Provide a smooth, debounced search experience.
- Use `MKLocalSearchCompleter` for suggestions.
- Eliminate layout "jarring" and nested scrolling issues.
- Improve visual feedback during the search process.

## Decisions

### 1. Dedicated Search View
- **Decision**: Create a `CitySearchView` that can be pushed or presented for city selection.
- **Rationale**: Trying to fit search results *inside* a `Form` alongside other fields is the primary cause of the "jarry" experience. A dedicated selection view is more idiomatic in iOS (e.g., Apple Maps, Calendar).

### 2. Search Completer & Debouncing
- **Decision**: Use `MKLocalSearchCompleter` to get `MKLocalSearchCompletion` results.
- **Rationale**: Completer is optimized for real-time keystroke suggestions. We will still implement a slight debounce (e.g., 300ms) to avoid redundant requests.

### 3. Unified Selection Flow
- **Decision**: `AddTripSheet` will now have buttons for "Origin", "Destination", and each "Stop" that open the `CitySearchView`.
- **Rationale**: Decouples the form data from the search interaction, preventing layout shifts in the form itself.

## Risks / Trade-offs

- **[Risk] Extra Tap** → **Mitigation**: While it adds one extra tap to open the search view, the actual interaction within that view will be much faster and smoother, leading to a better overall feeling.
