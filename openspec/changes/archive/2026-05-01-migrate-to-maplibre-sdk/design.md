## Context

The current Canvas-based map is difficult to maintain and lacks standard navigation features. Transitioning to MapLibre Compose allows us to use a dedicated Map SDK while keeping the project 100% free and open-source.

## Goals / Non-Goals

**Goals:**
- Integrate MapLibre Compose for Android and iOS.
- Use GeoJSON for high-accuracy state boundaries.
- Support pan, zoom, and interactive features natively provided by the SDK.
- Retain the "Green Highlight for visited capital" logic using SDK styling.

**Non-Goals:**
- Proprietary Map SDKs (Google Maps, Mapbox).
- Custom tile hosting (we will use a free public tile provider like OpenFreeMap).

## Decisions

### 1. SDK: MapLibre Compose
We will use `io.github.dellisd.spatialk:maplibre-compose` (or similar stable KMP wrapper).
- **Rationale**: Truly open-source, no API keys, strong KMP support.

### 2. Data Source: GeoJSON
We will bundle a `india_states.geojson` file in the app resources.
- **Rationale**: Industry standard for Map SDKs, easy to style, more accurate than SVG path strings for maps.

### 3. Styling: Data-Driven expressions
State highlighting will be handled via MapLibre's expression language (e.g., `match` or `in` expressions) applied to a `FillLayer`.

## Risks / Trade-offs

- **[Risk] Asset Size** → High-res GeoJSON can be large.
- **[Mitigation]** Use simplified GeoJSON (Topology preserved) to keep file size under 1MB.

- **[Risk] SDK Stability** → KMP Map SDKs are newer than native ones.
- **[Mitigation]** Fallback to native interop if the Compose wrapper has critical bugs.
