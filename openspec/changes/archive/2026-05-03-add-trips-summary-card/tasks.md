## 1. ViewModel

- [x] 1.1 Create `TripsSummaryViewModel.swift` with published properties for the statistics.
- [x] 1.2 Implement the logic to fetch data from `TripManager`, `StateVisitManager`, and `CityVisitManager` and calculate the statistics.
- [x] 1.3 Update `TripsSummaryViewModel` to expose lists of visited cities and states derived from trips.

## 2. View

- [x] 2.1 Create `TripsSummaryView.swift` which takes `TripsSummaryViewModel` as a dependency.
- [x] 2.2 Implement the UI for the summary card to display the statistics.
- [x] 2.3 Create `TripsDetailedSummaryView.swift` to show the lists of visited states and cities.
- [x] 2.4 Update `TripsSummaryView` to navigate to `TripsDetailedSummaryView` on tap.

## 3. Integration

- [x] 3.1 In `TripsView.swift`, instantiate `TripsSummaryViewModel` and `TripsSummaryView`.
- [x] 3.2 Add the `TripsSummaryView` to the top of the `TripsView`'s body.

## 4. Testing

- [x] 4.1 Add unit tests for `TripsSummaryViewModel` to verify the calculation logic.
- [x] 4.2 Add unit tests for the lists of visited cities and states in `TripsSummaryViewModel`.
