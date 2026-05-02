## Requirements

### Requirement: Interactive Map of India
The system SHALL display an interactive MapKit view focused on India.

#### Scenario: Display Map on Launch
- **WHEN** the user opens the application
- **THEN** the system SHALL display a `MKMapView` centered on the geographic bounds of India

### Requirement: State Boundary Rendering
The map SHALL display distinct boundaries for all Indian states and union territories using a GeoJSON layer.

#### Scenario: View State Outlines
- **WHEN** the map is rendered
- **THEN** the system SHALL draw visible borders separating different states of India using a `MKPolygonRenderer`

### Requirement: State Interaction
The system SHALL respond to user taps on state polygons by opening a selection interface instead of toggling status.

#### Scenario: Tap on State
- **WHEN** the user taps on a state polygon on the map
- **THEN** the system SHALL open the City Selection Sheet for that state

### Requirement: City and Capital Markers
The system SHALL display markers for all state capitals and all cities marked as visited on the map using user-defined colors.

#### Scenario: View Markers
- **WHEN** the map is rendered
- **THEN** the system SHALL display `MKAnnotation` markers for all visited cities and all state capitals using the current color settings

#### Scenario: Differentiate Capitals
- **WHEN** a capital city is rendered on the map
- **THEN** the system SHALL use the "Capital Marker Color" to distinguish it from regular cities which use the "City Marker Color"
