## ADDED Requirements

### Requirement: City Visit Persistence
The system SHALL persist visited cities locally on the device.

#### Scenario: Mark city as visited
- **WHEN** a user marks a city as visited in a state
- **THEN** the system SHALL store this city ID and its state association in persistent storage

#### Scenario: Unmark city as visited
- **WHEN** a user removes a city from visited list
- **THEN** the system SHALL remove it from persistent storage

### Requirement: Data Migration
The system SHALL migrate existing state visits to city visits upon first launch after this update.

#### Scenario: Legacy state migration
- **WHEN** the app is launched and legacy `visitedStates` exist
- **THEN** the system SHALL automatically mark the capital city of each visited state as "visited" in the new storage
