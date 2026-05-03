## MODIFIED Requirements

### Requirement: Trips Tab Interface
The system SHALL provide a "Trips" tab in the bottom navigation bar to manage journeys, displaying a summary card and all recorded trips sorted by date (newest first).

#### Scenario: View Trips List with Summary Card
- **WHEN** the user taps the "Trips" tab item
- **THEN** the system SHALL display a summary card with travel statistics
- **AND** the system SHALL display a list of all recorded trips below the summary card

#### Scenario: View Trips List with Stops
- **WHEN** the user taps the "Trips" tab item
- **THEN** the system SHALL display a list of all recorded trips
- **AND** the system SHALL indicate if a trip has intermediate stops (e.g., "Origin to Destination (X stops)")
