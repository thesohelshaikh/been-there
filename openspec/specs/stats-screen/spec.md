## Requirements

### Requirement: Stats Summary View
The system SHALL provide a summary view showing the total number of states/UTs visited and the percentage of India covered.

#### Scenario: User views stats summary
- **WHEN** the user navigates to the Stats Screen
- **THEN** the system SHALL display "X of 36 entities Visited" and a progress indicator showing (X/36 * 100)%

### Requirement: State & UT Breakdown List
The system SHALL display a list of all 36 Indian States and Union Territories, indicating which ones have been visited.

#### Scenario: User views state list
- **WHEN** the user scrolls the Stats Screen
- **THEN** the system SHALL display a list of all states and UTs with a checkmark next to those stored in `StateVisitManager.visitedStates`

### Requirement: Regional Progress Tracking
The system SHALL display progress bars for each travel region.

#### Scenario: Regional progress update
- **WHEN** the user visits a state in a region
- **THEN** the system SHALL update the linear progress indicator for that region
