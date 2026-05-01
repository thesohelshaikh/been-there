## ADDED Requirements

### Requirement: Capital City Recognition
The system SHALL maintain a mapping of Indian states to their respective capital cities.

#### Scenario: Verify Capital status
- **WHEN** a city is marked as visited
- **THEN** the system SHALL check if that city is the registered capital of any state

### Requirement: Green Highlight for Visited Capitals
The system SHALL apply a green overlay to a state on the map if its capital city has been visited.

#### Scenario: State capital visited
- **WHEN** the user marks "Mumbai" as visited (Capital of Maharashtra)
- **THEN** the system SHALL display the state of Maharashtra with a green layer on the map

#### Scenario: Non-capital city visited
- **WHEN** the user marks "Pune" as visited (Not a capital)
- **THEN** the system SHALL NOT apply the green layer to Maharashtra unless Mumbai is also visited
