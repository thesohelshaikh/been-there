# BeenThere Project Context

This is a native iOS application built with SwiftUI, focusing on tracking travel across Indian states and union territories.

## Project Overview

*   **Goal:** Provide an interactive map of India to track visited regions and display coverage statistics.
*   **Core Technologies:**
    *   **Language:** Swift
    *   **UI Framework:** SwiftUI
    *   **Maps:** MapKit (currently using `MKMapView` with GeoJSON overlays).
    *   **Persistence:** `UserDefaults` (via `StateVisitManager`).
    *   **Build System:** XcodeGen (managed by `project.yml`).
*   **Architecture:** MVVM (Model-View-ViewModel).
    *   `StateVisitManager`: Central source of truth for visited states.
    *   `TripManager`: Manages the lifecycle and persistence of recorded trips.
    *   `StatsViewModel`: Computes statistics and regional coverage.
    *   `IndiaMapView`: SwiftUI wrapper (`UIViewRepresentable`) for `MKMapView`.

## Workflow & Tools

*   **OpenSpec:** The project follows a spec-driven development process. All major changes are documented in the `openspec/` directory.
    *   Active/Recent changes can be found in `openspec/changes/`.
    *   Archived changes are in `openspec/changes/archive/`.
*   **Gemini CLI Skills:** Custom skills for managing the OpenSpec workflow are located in `.gemini/skills/`.
    *   `/opsx:propose`: Generate a new change proposal.
    *   `/opsx:apply`: Start implementing tasks from a change.
    *   `/opsx:archive`: Finalize and archive a completed change.

## Building and Running

*   **Project Generation:**
    ```bash
    # Ensure xcodegen is installed (brew install xcodegen)
    xcodegen generate
    ```
*   **Building:** Open `BeenThere.xcodeproj` in Xcode or use `xcodebuild`.
*   **Testing:**
    *   Primary test suite: `BeenThereTests`.
    *   Run tests via Xcode (Cmd+U) or `xcodebuild test`.

## Development Conventions

1.  **UI:** Use SwiftUI for all new views. Use `UIViewRepresentable` only when native SwiftUI components are insufficient (e.g., complex MapKit interactions).
2.  **State Management:** Follow the existing pattern of using `ObservableObject` and `@Published`. Shared state should be managed via `StateVisitManager`.
3.  **Map Data:** Use `india_states.geojson` (in `Resources`) for map boundaries.
4.  **Spec-Driven Development:** Before implementing new features, use `/opsx:propose` to create a design and task list in the `openspec` directory.
5.  **Testing:** Add unit tests for ViewModels in `BeenThereTests`.

## Key Files

*   `project.yml`: XcodeGen configuration.
*   `BeenThere/App/BeenThereApp.swift`: App entry point.
*   `BeenThere/UI/StateVisitManager.swift`: Persistence logic for visited states.
*   `BeenThere/UI/TripManager.swift`: Management of road trips and intermediate stops.
*   `BeenThere/UI/TripsView.swift`: The main view for managing journeys.
*   `BeenThere/UI/TripsSummaryView.swift`: A card-based dashboard for travel statistics.
*   `BeenThere/UI/IndiaMapView.swift`: Map implementation using MapKit.
*   `BeenThere/Resources/india_states.geojson`: Geographic data for the map.
*   `openspec/`: Development specifications and task tracking.
