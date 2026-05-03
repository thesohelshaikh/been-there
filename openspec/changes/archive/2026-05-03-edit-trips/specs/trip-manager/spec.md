## ADDED Requirements

### Requirement: Update Existing Trip
The system SHALL allow updating the details of an existing trip while preserving its unique identifier.

#### Scenario: Edit Trip Successfully
- **WHEN** a user modifies a trip and saves the changes
- **THEN** the system SHALL replace the existing trip record with the updated data in `UserDefaults`
