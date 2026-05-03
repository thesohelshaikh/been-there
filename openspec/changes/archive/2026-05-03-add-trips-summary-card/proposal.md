## Why

The trips page currently lists all the trips but lacks a high-level summary. Adding a summary card will provide users with a quick overview of their travel statistics, enhancing the user experience.

## What Changes

- A new summary card will be added to the top of the Trips page.
- The card will display the following statistics:
    - Total number of states visited.
    - Total number of cities visited.
    - Total number of trips logged.
    - Total kilometers travelled across all trips.
    - Average trip length (in km).
    - A detailed summary view that opens when tapping the card, showing a list of states and cities visited.

    ## Capabilities

    ### New Capabilities
    - `trips-summary-card`: Displays travel statistics on the Trips page.
    - `trips-detailed-summary`: Displays a detailed breakdown of visited states and cities.
### Modified Capabilities
- `trips-tab`: The trips tab will be updated to include the summary card.

## Impact

- The `TripsView.swift` will be modified to include the new summary card.
- A new SwiftUI view will be created for the summary card.
- The `StatsViewModel.swift` might be updated to include the new stats, or a new ViewModel will be created.
