## 1. Setup & Dependencies

- [x] 1.1 Add `multiplatform-settings` dependency to `commonMain` in `libs.versions.toml` and `build.gradle.kts`.
- [x] 1.2 Create directory structure for map assets in `commonMain/composeResources`.

## 2. Data Layer

- [x] 2.1 Prepare `india_states.json` containing state names, capitals, and simplified SVG path data.
- [x] 2.2 Implement `CityVisitManager` class in `commonMain` to handle persistence of visited city IDs using `multiplatform-settings`.

## 3. Domain Logic

- [x] 3.1 Implement `StateVisitLogic` to determine if a state should be highlighted based on the visited capitals list.
- [x] 3.2 Create a repository/use-case to provide the list of states with their current "visited" status.

## 4. UI Components

- [x] 4.1 Implement `IndiaMap` Composable that renders the SVG paths from `india_states.json`.
- [ ] 4.2 Add zoom and pan functionality to the `IndiaMap` (optional but recommended for UX).
- [x] 4.3 Implement dynamic styling for state paths (e.g., green fill for visited states).
- [x] 4.4 Create a `CitySelectionDialog` or search bar to allow users to mark a city as visited.

## 5. Integration & Testing

- [x] 5.1 Connect `IndiaMap` to `CityVisitManager` so it updates when a new city is marked.
- [x] 5.2 Add unit tests for `StateVisitLogic` to ensure capital city matching works correctly.
- [x] 5.3 Verify the "India focus" requirement is met on both Android and iOS targets.
