## MODIFIED Requirements

### Requirement: Interactive Map of India
The system SHALL display an interactive MapLibre view focused on India.

#### Scenario: Display Map on Launch
- **WHEN** the user opens the application
- **THEN** the system SHALL display a MapLibre view centered on the geographic bounds of India

### Requirement: State Boundary Rendering
The map SHALL display distinct boundaries for all Indian states and union territories using a GeoJSON layer.

#### Scenario: View State Outlines
- **WHEN** the map is rendered
- **THEN** the system SHALL draw visible borders separating different states of India using a MapLibre `LineLayer` or `FillLayer`

### Requirement: Dynamic State Highlighting
The system SHALL apply a green fill to a state layer if its capital city has been visited.

#### Scenario: State Highlighted in Green
- **WHEN** a state is marked as visited in the data layer
- **THEN** the MapLibre `FillLayer` SHALL update its data-driven styling to show that state in green
