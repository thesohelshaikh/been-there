## Why

Users want to see their travel progress in India at a glance. Currently, they can only see visited states on the map, but they lack a centralized view of statistics such as the percentage of states/UTs visited and specific milestones achieved. This feature will increase user engagement by gamifying the travel experience.

## What Changes

- **New Stats Screen**: A dedicated view to display comprehensive travel statistics.
- **Progress Visualizations**: Circular or linear progress bars showing the percentage of states and cities visited.
- **State Breakdown**: A list of all Indian states/UTs categorized by their visit status.
- **Milestones**: Tracking and displaying travel milestones based on existing state/city logic.
- **Navigation**: Add a button to the main view to navigate to the Stats Screen.

## Capabilities

### New Capabilities
- `stats-screen`: Provides the UI and underlying logic for aggregating visit data and displaying it as statistics, progress bars, and milestones.

### Modified Capabilities
- None.

## Impact

- **UI**: New navigation element in `ContentView`.
- **Data**: Reads data from `StateVisitManager` and `CityVisitManager` (to be implemented/integrated).
- **Architecture**: Introduction of a new View and potentially a ViewModel for statistics.
