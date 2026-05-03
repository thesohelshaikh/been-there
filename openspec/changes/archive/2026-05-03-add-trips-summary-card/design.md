## Context

The `TripsView` currently displays a list of trips. The user wants to see a summary of their trips at the top of this view. Data for stats is available from `TripManager`, `StateVisitManager`, and `CityVisitManager`.

## Goals / Non-Goals

**Goals:**
- Implement a new SwiftUI view, `TripsSummaryView`, to display the travel statistics.
- Integrate `TripsSummaryView` into `TripsView`.
- Fetch and calculate the required statistics: states visited, cities visited, number of trips, and kilometers travelled. A new stat 'average trip length' will also be added.

**Non-Goals:**
- This change will not introduce any new persistence layer. It will rely on the existing managers.
- No changes to the existing trip list UI.

## Decisions

1.  **Create a new ViewModel `TripsSummaryViewModel`**: This ViewModel will be responsible for fetching the data from the different managers (`TripManager`, `StateVisitManager`, `CityVisitManager`) and providing the formatted statistics to the `TripsSummaryView`. It will also provide the detailed data for `TripsDetailedSummaryView`.
2.  **`TripsSummaryView`**: A new SwiftUI view will be created to render the summary card. It will take `TripsSummaryViewModel` as a dependency. It will wrap its content in a `NavigationLink` to navigate to the detailed view.
3.  **`TripsDetailedSummaryView`**: A new SwiftUI view to display the lists of visited states and cities.
4.  **Update `TripsView`**: The `TripsView` will instantiate the `TripsSummaryView` and its ViewModel and display it at the top of the view.

## Risks / Trade-offs

- [Risk] Performance: If the number of trips is very large, calculating the total kilometers and other stats on the main thread could cause UI lag. -> Mitigation: The calculation is simple and the number of trips is not expected to be huge for a typical user. If this becomes an issue, the calculation can be moved to a background thread.
- [Risk] UI Complexity: Adding a detailed view adds another layer of navigation. -> Mitigation: Keep the detailed view simple and focused on the lists requested.
