## ADDED Requirements

### Requirement: Trips Tab Interface
The system SHALL provide a "Trips" tab in the bottom navigation bar to manage journeys.

#### Scenario: View Trips List
- **WHEN** the user taps the "Trips" tab item
- **THEN** the system SHALL display a list of all recorded trips, sorted by date (newest first)

### Requirement: Add New Trip
The system SHALL provide a form to record a new trip between two cities.

#### Scenario: Add Trip via Search
- **WHEN** the user provides an origin city, a destination city, selects a transport mode, and sets a date/time
- **THEN** the system SHALL create a new trip and add it to the trips list

### Requirement: Transport Mode Selection
The system SHALL allow users to choose from Plane, Train, Car, or Bike for each trip.

#### Scenario: Select Mode
- **WHEN** creating a trip
- **THEN** the system SHALL present options for Plane, Train, Car, and Bike with corresponding icons
