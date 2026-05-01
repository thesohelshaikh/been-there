## 1. Data Model & Logic

- [x] 1.1 Create `StatsViewModel` to handle statistics calculations.
- [x] 1.2 Define Indian states/UTs and their regional mapping in `StatsViewModel`.
- [x] 1.3 Implement logic to calculate percentage of states visited from `StateVisitManager`.
- [x] 1.4 Implement `CityVisitManager` and integrate city tracking into `StatsViewModel`.

## 2. UI Components (Redesign)

- [x] 2.1 Create `ProgressCard` with circular progress and journey summary.
- [x] 2.2 Create `MiniStatCard` for quick state/city counts.
- [x] 2.3 Create `RegionProgressRow` for detailed regional breakdown.
- [x] 2.4 Create `CityVisitedRow` for the list of visited cities.
- [x] 2.5 Assemble all components into the revamped `StatsView`.

## 3. Navigation & Layout

- [x] 3.1 Implement `TabView` in `ContentView` as the main navigation structure.
- [x] 3.2 Add "Map", "Stats", "Places", and "Settings" tabs with appropriate icons.
- [x] 3.3 Ensure `StatsView` correctly observes both `StateVisitManager` and `CityVisitManager`.

## 4. Verification

- [x] 4.1 Verify UI matches the requested design image.
- [x] 4.2 Verify tab navigation works correctly.
- [x] 4.3 Verify statistics update in real-time when visit data changes.
