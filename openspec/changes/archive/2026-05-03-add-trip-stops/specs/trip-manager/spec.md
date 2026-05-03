## MODIFIED Requirements

### Requirement: Trip Persistence
The system SHALL persist trip data across app launches using local storage, including all intermediate stops.

#### Scenario: Save Trip with Stops
- **WHEN** a new trip with intermediate stops is added via the UI
- **THEN** the system SHALL store the trip details (origin, stops, destination, mode, date) in `UserDefaults`

#### Scenario: Load Trips with Stops
- **WHEN** the app is launched
- **THEN** the system SHALL retrieve all stored trips, ensuring stops are correctly loaded and preserved in sequence
