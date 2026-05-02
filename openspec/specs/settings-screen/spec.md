## ADDED Requirements

### Requirement: Dark Mode Toggle
The system SHALL provide a toggle switch in the Settings screen to enable or disable Dark Mode.

#### Scenario: Toggle Dark Mode On
- **WHEN** the user switches the "Dark Mode" toggle to ON
- **THEN** the application interface SHALL transition to a dark color scheme immediately

### Requirement: Visited State Color Customization
The system SHALL allow users to select a custom highlight color for visited states.

#### Scenario: Change Visited Color
- **WHEN** the user selects a new color from the color picker in Settings
- **THEN** the Map View SHALL update the visited states' overlay color to match the selection

### Requirement: Map Style Selection
The system SHALL allow users to toggle between Standard and Satellite map styles.

#### Scenario: Switch to Satellite View
- **WHEN** the user selects "Satellite" in Map Settings
- **THEN** the Map View SHALL update its base tile layer to satellite imagery

### Requirement: Data Portability (Export/Import)
The system SHALL allow users to export their travel data as a JSON file and import a previously exported file.

#### Scenario: Export Data
- **WHEN** the user taps "Export Data"
- **THEN** the system SHALL present a share sheet with a JSON file containing all visited states/cities

#### Scenario: Import Data
- **WHEN** the user selects a valid JSON file via "Import Data"
- **THEN** the system SHALL merge or overwrite current data with the imported states

### Requirement: App Information
The system SHALL display the current app version and provide links to the project's source code.

#### Scenario: View Version Info
- **WHEN** the user scrolls to the "About" section in Settings
- **THEN** they SHALL see the current version and build number

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
