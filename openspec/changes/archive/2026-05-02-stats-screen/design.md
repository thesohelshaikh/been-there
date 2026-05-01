## Context

The BeenThere app allows users to mark Indian states as visited on a map. Data is managed by `StateVisitManager`. Currently, there is no way for users to see aggregated statistics or a list of visited states.

## Goals / Non-Goals

**Goals:**
- Provide a clear summary of travel progress (states/UTs visited).
- Show a comprehensive list of all Indian states/UTs with their visit status.
- Reward progress with milestones (regional and cumulative).
- Integration with existing `StateVisitManager`.

**Non-Goals:**
- Social sharing of statistics (future scope).
- Detailed city-level statistics in this version.
- Editing visit status directly from the Stats Screen (to be decided, but primarily read-only for now).

## Decisions

- **Navigation Architecture**: Add a "chart" icon button in the `ContentView` navigation bar that opens the Stats Screen in a `NavigationView` via a `.sheet`.
- **UI Components**:
    - `ProgressView` for the overall coverage.
    - `List` with `Section`s for state breakdown.
    - `Card` style views for milestones.
- **Data Management**:
    - The `StatsView` will observe `StateVisitManager`.
    - A `StatsViewModel` will be created to handle the logic for calculating milestones and regional progress.
- **Region Definitions**: Regions (North, South, East, West, Central, Northeast) will be defined as a hardcoded mapping in `StatsViewModel` since they are static for Indian states.

## Risks / Trade-offs

- **[Risk] Performance with 36 states list** → **[Mitigation]** Use SwiftUI `List` which is lazy-loaded by default.
- **[Risk] Regional definitions vary** → **[Mitigation]** Use the standard Ministry of Home Affairs regional council definitions.
