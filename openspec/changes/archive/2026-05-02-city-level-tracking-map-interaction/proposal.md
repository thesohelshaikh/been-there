## Why

Currently, tapping a state on the map toggles its "visited" status directly. Users want more granular tracking by marking specific cities they have visited within each state. This change shifts the interaction from state-level toggling to city-level selection, providing a more detailed travel log. Additionally, visualizing these cities and capitals directly on the map improves the sense of progress and discovery.

## What Changes

- **BREAKING**: Tapping a state polygon on the map no longer toggles the state's visited status.
- New interaction: Tapping a state opens a bottom sheet allowing users to search and mark cities within that state as visited.
- State "visited" status is now derived: A state is marked as visited on the map only if its capital city is marked as visited.
- **Visuals**: The map now displays markers (annotations) for capital cities and all cities marked as visited.
- Integration with MapKit Search for discovering and adding cities.
- Data migration: Existing visited states will be migrated by automatically marking their capital cities as visited.

## Capabilities

### New Capabilities
- `city-visit-manager`: Handles persistence and management of visited cities across all states.
- `city-selection-sheet`: Provides a UI for searching cities using MapKit and toggling their visited status.

### Modified Capabilities
- `map-india-view`: Requirements change from state-toggling to opening the city-selection sheet, and adding city/capital annotations.
- `state-milestone-logic`: Logic for marking a state as visited changes from manual toggle to "Capital City Visited" check.

## Impact

- `IndiaMapView.swift`: Update gesture handling, rendering logic, and implement `MKAnnotation` support.
- `StateVisitManager.swift`: Update to observe city visits or integrate with `CityVisitManager`.
- `StatsViewModel.swift`: Update statistics calculation to reflect city-based state status.
- New `CityVisitManager.swift` and `CitySelectionSheet.swift` components.
