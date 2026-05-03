## MODIFIED Requirements

### Requirement: Add New Trip
The system SHALL provide a form to record a new trip, with a smooth and responsive city selection experience.

#### Scenario: Smooth City Selection
- **WHEN** the user selects a location (origin, destination, or stop) in the trip form
- **THEN** the system SHALL present a dedicated search interface that provides real-time, debounced suggestions
- **AND** the system SHALL allow the user to select a city from the results without causing layout jumps in the main form
