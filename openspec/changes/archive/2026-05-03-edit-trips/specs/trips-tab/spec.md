## ADDED Requirements

### Requirement: Edit Trip UI
The system SHALL provide a user interface to edit existing trips.

#### Scenario: Open Edit Sheet
- **WHEN** the user selects the edit action for a trip in the list
- **THEN** the system SHALL display the trip details in a form, allowing modifications

#### Scenario: Save Edited Trip
- **WHEN** the user saves the changes in the edit form
- **THEN** the system SHALL update the trip in the list and dismiss the form
