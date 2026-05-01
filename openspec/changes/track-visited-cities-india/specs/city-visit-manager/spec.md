## ADDED Requirements

### Requirement: Record City Visit
The system SHALL allow users to mark a city as "visited".

#### Scenario: User marks a city as visited
- **WHEN** the user selects a city from a list or on the map and confirms it is visited
- **THEN** the system SHALL record the city and the timestamp of the visit in local storage

### Requirement: Persistent Storage of Visits
The system SHALL persist the list of visited cities across application restarts.

#### Scenario: App restart retains data
- **WHEN** the user closes and reopens the app
- **THEN** the system SHALL load and display all previously marked visited cities
