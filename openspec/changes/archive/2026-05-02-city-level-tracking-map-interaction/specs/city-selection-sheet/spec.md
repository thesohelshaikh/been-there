## ADDED Requirements

### Requirement: City Search UI
The system SHALL provide a search interface to find cities within a selected state.

#### Scenario: Search for a city
- **WHEN** the user types a city name in the selection sheet
- **THEN** the system SHALL display matching results from MapKit filtered by the selected state

### Requirement: City Selection Toggle
The system SHALL allow users to toggle the "visited" status of cities.

#### Scenario: Toggle city visit
- **WHEN** the user taps a city in the search results
- **THEN** the system SHALL toggle its visited status and update the persistent storage
