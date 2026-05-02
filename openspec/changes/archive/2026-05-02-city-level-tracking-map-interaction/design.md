## Context

The current application tracks travel at the state level. This design introduces city-level tracking, where tapping a state on the map opens a selection interface. The "visited" status of a state is now derived from the visitation status of its capital city. Furthermore, cities and capitals are now visualized as markers on the map.

## Goals / Non-Goals

**Goals:**
- Implement `CityVisitManager` for persistent storage of visited cities.
- Update `IndiaMapView` to open a `CitySelectionSheet` on state tap.
- Implement city search using `MKLocalSearch` filtered by the selected state.
- Derived state status: State is "visited" if its capital city is marked as visited.
- **Visuals**: Show annotations for all capital cities and all visited cities on the map.
- Seamless migration of existing state visits to city visits (capitals).

**Non-Goals:**
- Automatic city detection via GPS.
- Tracking of non-city landmarks (monuments, etc.).
- Changing the Map rendering engine (staying with MapKit).

## Decisions

### 1. Persistence: CityVisitManager
We will implement a new `CityVisitManager` that stores a set of visited city identifiers in `UserDefaults`.
- **Decision**: Store `[StateName: Set<City>]` where `City` is a struct with name and coordinates.
- **Rationale**: Storing coordinates ensures markers can be placed accurately on the map without re-searching.

### 2. Map Annotations: Capitals and Visited Cities
- **Decision**: Use `MKPointAnnotation` for markers.
- **Decision**: Distinct styling for capitals vs regular cities.
    - Capitals: Star icon (yellow if visited, gray if not).
    - Regular Cities: Circle/Dot (green if visited).
- **Decision**: Only show markers for visited cities to avoid clutter. Always show capital markers for all states.

### 3. Derived State Status
- **Decision**: `StateVisitManager` will compute `visitedStates` by checking if each state's capital city exists in `CityVisitManager` and is marked as visited.

### 4. City Selection UI
- **Decision**: Use a SwiftUI `.sheet` presenting a search interface using `MKLocalSearch`. When a city is selected, its metadata (name, coordinates) is saved to `CityVisitManager`.

### 5. Migration Strategy
- **Decision**: Legacy `visitedStates` will be converted by marking their respective capitals as visited in `CityVisitManager`. Coordinates for capitals will be sourced from `india_states.json` (if available) or via a one-time `MKLocalSearch`.

## Risks / Trade-offs

- **[Risk] Cluttering the Map** → Mitigation: Only render visited cities and capitals. Group or decluster annotations if necessary (MapKit built-in clustering).
- **[Risk] Coordinate Accuracy** → Mitigation: Use MapKit search results directly for coordinate data to ensure alignment with the map.
