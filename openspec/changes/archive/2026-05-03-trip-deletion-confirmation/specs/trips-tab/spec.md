## MODIFIED Requirements

### Requirement: Trips Tab Interface
The system SHALL provide a "Trips" tab to manage journeys, including a confirmation step for deletions.

#### Scenario: Confirm Trip Deletion
- **WHEN** the user attempts to delete a trip from the list
- **THEN** the system SHALL present a confirmation dialog asking for confirmation
- **AND** the trip SHALL only be removed if the user confirms the action
