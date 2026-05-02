## MODIFIED Requirements

### Requirement: City and Capital Markers
The system SHALL display markers for all state capitals and all cities marked as visited on the map using user-defined colors.

#### Scenario: View Markers
- **WHEN** the map is rendered
- **THEN** the system SHALL display `MKAnnotation` markers for all visited cities and all state capitals using the current color settings

#### Scenario: Differentiate Capitals
- **WHEN** a capital city is rendered on the map
- **THEN** the system SHALL use the "Capital Marker Color" to distinguish it from regular cities which use the "City Marker Color"
