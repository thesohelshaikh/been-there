## ADDED Requirements

### Requirement: Trip Persistence
The system SHALL persist trip data across app launches using local storage.

#### Scenario: Save Trip
- **WHEN** a new trip is added via the UI
- **THEN** the system SHALL store the trip details (origin, destination, mode, date) in `UserDefaults`

#### Scenario: Load Trips on Launch
- **WHEN** the app is launched
- **THEN** the system SHALL retrieve all stored trips from `UserDefaults` and make them available to the UI

### Requirement: Delete Trip
The system SHALL allow users to delete recorded trips.

#### Scenario: Remove Trip
- **WHEN** a user selects a trip to delete
- **THEN** the system SHALL remove the trip from local storage and update the UI
