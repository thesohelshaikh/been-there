## MODIFIED Requirements

### Requirement: Trip Visualization
The map SHALL visualize recorded trips as polylines connecting the origin, all intermediate stops, and the destination in sequence.

#### Scenario: View Multi-stop Trip on Map
- **WHEN** a trip with intermediate stops is rendered on the map
- **THEN** the system SHALL draw a continuous `MKPolyline` connecting all coordinates in the trip's sequence (Origin -> Stop 1 -> ... -> Destination)
