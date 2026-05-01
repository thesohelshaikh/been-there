## Context

The "Been There" application is a Compose Multiplatform project. This design addresses the first major feature: an interactive map of India that allows users to track their travels by city and rewards state-level progress (visiting capitals).

## Goals / Non-Goals

**Goals:**
- Render an interactive, performant map of India with state-level granularity.
- Persist a list of visited cities locally on the device.
- Implement logic to highlight a state in green when its capital city is marked as visited.
- Support both Android and iOS targets.

**Non-Goals:**
- Implementation of a global map view (Phase 2).
- Server-side synchronization or user accounts.
- Navigation or routing between cities.

## Decisions

### 1. Map Rendering Engine: Vector-based (SVG/Path)
We will use a vector-based approach (drawing `Path` objects in Compose) rather than an interactive tile-based map (like Google Maps).
- **Rationale**: Vector maps provide full control over styling (e.g., coloring individual states green), require no API keys, work offline, and are highly performant for a fixed geographic scope like India.
- **Alternatives**: Google Maps Compose (high overhead, requires API keys, harder to style individual state polygons dynamically).

### 2. Local Persistence: Multiplatform Settings
We will use the `multiplatform-settings` library to store the list of visited city identifiers.
- **Rationale**: It provides a simple, unified API for `SharedPreferences` (Android) and `NSUserDefaults` (iOS), which is sufficient for a simple list of strings.
- **Alternatives**: SQLDelight (overkill for a single list), KStore.

### 3. Data Schema: Bundled JSON
State and capital city metadata (including SVG path data for boundaries) will be bundled as a JSON resource in `commonMain`.
- **Rationale**: Keeps the application self-contained and ensures the UI can render immediately without network calls.

## Risks / Trade-offs

- **[Risk] Path Complexity** → High-detail boundaries might impact rendering performance on older devices.
- **[Mitigation]** Use simplified GeoJSON paths (e.g., via mapshaper.org) to reduce point count while maintaining recognizable shapes.

- **[Risk] Screen Responsiveness** → A fixed-path map needs to scale correctly across different screen aspect ratios.
- **[Mitigation]** Use a `BoxWithConstraints` and a custom `ContentScale` to ensure the India map remains centered and correctly proportioned.
