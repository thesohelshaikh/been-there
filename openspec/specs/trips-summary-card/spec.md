## Requirements

### Requirement: Display Travel Statistics
The system SHALL display a summary of travel statistics.

#### Scenario: All stats are available
- **WHEN** the user navigates to the Trips tab
- **THEN** the summary card SHALL display the total number of states visited, cities visited, trips, and kilometers travelled, and average trip length.

#### Scenario: No trips are logged
- **WHEN** the user has not logged any trips
- **THEN** the summary card SHALL display 0 for all statistics.
