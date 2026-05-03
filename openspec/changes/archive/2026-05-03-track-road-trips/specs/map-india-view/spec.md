## ADDED Requirements

### Requirement: Trip Visualization
The map SHALL visualize recorded trips as polylines connecting the origin and destination cities.

#### Scenario: View Trips on Map
- **WHEN** the map is rendered and trips exist
- **THEN** the system SHALL draw `MKPolyline` overlays between the coordinates of the origin and destination cities for each trip

#### Scenario: Toggle Trip Visibility
- **WHEN** the user changes the "Show Trips on Map" setting (if available)
- **THEN** the system SHALL add or remove the trip overlays from the map accordingly
