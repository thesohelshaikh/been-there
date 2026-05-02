## MODIFIED Requirements

### Requirement: Green Highlight for Visited Capitals
The system SHALL apply a green overlay to a state on the map if its capital city has been visited.

#### Scenario: State capital visited
- **WHEN** the user marks the capital of a state (e.g., "Mumbai" for Maharashtra) as visited
- **THEN** the system SHALL display the state of Maharashtra with a green layer on the map

#### Scenario: Non-capital city visited
- **WHEN** the user marks a non-capital city (e.g., "Pune") as visited
- **THEN** the system SHALL NOT apply the green layer to the state unless the capital is also visited
