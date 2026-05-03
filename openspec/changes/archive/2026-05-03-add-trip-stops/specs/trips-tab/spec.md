## MODIFIED Requirements

### Requirement: Add New Trip
The system SHALL provide a form to record a new trip between two cities, with support for multiple intermediate stops.

#### Scenario: Add Trip with Multiple Stops
- **WHEN** the user provides an origin, a destination, one or more intermediate stops, selects a mode, and sets a date
- **THEN** the system SHALL create a new trip containing all provided locations in the correct sequence

### Requirement: Trips Tab Interface
The system SHALL provide a "Trips" tab to manage journeys, displaying stop information for multi-stop trips.

#### Scenario: View Trips List with Stops
- **WHEN** the user views the trips list
- **THEN** the system SHALL indicate if a trip has intermediate stops (e.g., "Origin to Destination (X stops)")
