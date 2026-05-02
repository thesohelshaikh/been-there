## ADDED Requirements

### Requirement: Capital Marker Color Customization
The system SHALL allow users to select a custom color for capital city markers in the Settings screen.

#### Scenario: Change Capital Marker Color
- **WHEN** the user selects a new color from the "Capital Marker Color" picker
- **THEN** the Map View SHALL update the capital city markers to the new color immediately

### Requirement: City Marker Color Customization
The system SHALL allow users to select a custom color for visited city markers in the Settings screen.

#### Scenario: Change City Marker Color
- **WHEN** the user selects a new color from the "City Marker Color" picker
- **THEN** the Map View SHALL update the visited city markers to the new color immediately

### Requirement: Reset Appearance Defaults
The system SHALL provide a button in the Settings screen to reset all appearance-related settings to their default values.

#### Scenario: Reset Settings
- **WHEN** the user taps the "Reset to Defaults" button
- **THEN** the system SHALL restore "Visited State Color", "Capital Marker Color", "City Marker Color", and "Map Style" to their factory default values
- **THEN** the Map View SHALL update its appearance immediately to reflect these defaults
