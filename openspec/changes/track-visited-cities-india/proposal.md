## Why

Travelers often want a visual way to track their journeys and milestones. This change introduces an interactive map-based tracking system for India, gamifying the experience by highlighting states when their capitals are visited, thus encouraging users to explore every state in the country.

## What Changes

- **Map of India Integration**: Added a dedicated screen to display an interactive map of India with state boundaries.
- **City Visit Tracking**: Implementation of a system to mark specific cities as "visited".
- **Capital City Recognition**: Logic to identify if a visited city is the capital of an Indian state.
- **Dynamic State Highlighting**: Visual green overlay for states on the map once their capital city has been recorded as visited.

## Capabilities

### New Capabilities
- `map-india-view`: Interactive map component configured to show India and its state boundaries.
- `city-visit-manager`: Data management layer for recording and retrieving visited cities.
- `state-milestone-logic`: Rules engine to trigger state highlighting based on capital city visits.

### Modified Capabilities
- None

## Impact

- **UI**: New map-centric dashboard and city selection interface.
- **Data**: New persistence layer for travel history.
- **Dependencies**: Addition of a Compose Multiplatform compatible map library (e.g., Google Maps Compose or a vector-based alternative).
