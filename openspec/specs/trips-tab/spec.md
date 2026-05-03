## Requirements

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

### Requirement: Add New Trip
The system SHALL provide a form to record a new trip between two cities, with support for multiple intermediate stops and a smooth selection experience.

#### Scenario: Add Trip with Multiple Stops
- **WHEN** the user provides an origin, a destination, and optional intermediate stops
- **THEN** the system SHALL create a new trip containing all provided locations in the correct sequence

#### Scenario: Smooth City Selection
- **WHEN** the user selects a location (origin, destination, or stop) in the trip form
- **THEN** the system SHALL present a dedicated search interface that provides real-time, debounced suggestions using `MKLocalSearchCompleter`

### Requirement: Edit Trip UI
The system SHALL provide a user interface to edit existing trips.

#### Scenario: Open Edit Sheet
- **WHEN** the user selects the edit action (e.g., leading swipe) for a trip in the list
- **THEN** the system SHALL display the trip details in a form, allowing modifications

#### Scenario: Save Edited Trip
- **WHEN** the user saves the changes in the edit form
- **THEN** the system SHALL update the trip in the list and dismiss the form

### Requirement: Confirm Trip Deletion
The system SHALL require explicit confirmation before deleting a trip.

#### Scenario: Confirm Trip Deletion
- **WHEN** the user attempts to delete a trip (e.g., trailing swipe)
- **THEN** the system SHALL present a confirmation dialog
- **AND** the trip SHALL only be removed if the user confirms the action

### Requirement: Transport Mode Selection
The system SHALL allow users to choose from Plane, Train, Car, or Bike for each trip.

#### Scenario: Select Mode
- **WHEN** creating or editing a trip
- **THEN** the system SHALL present options for Plane, Train, Car, and Bike with corresponding icons
