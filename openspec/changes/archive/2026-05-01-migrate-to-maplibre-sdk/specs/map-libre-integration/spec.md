## ADDED Requirements

### Requirement: MapLibre Initialization
The system SHALL initialize the MapLibre SDK and display a map.

#### Scenario: Display MapLibre on Launch
- **WHEN** the user opens the map screen
- **THEN** the system SHALL display a MapLibre map centered on India

### Requirement: Free Tile Provider
The map SHALL use a free and open-source tile provider (e.g., OpenFreeMap or MapLibre's default styles).

#### Scenario: Verify Tile Loading
- **WHEN** the map is rendered
- **THEN** the system SHALL load base map tiles without requiring a proprietary API key
