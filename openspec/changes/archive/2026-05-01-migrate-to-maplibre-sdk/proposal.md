## Why

The current Canvas-based implementation, while functional and free, lacks standard map features like smooth panning, zooming, and a professional aesthetic. Transitioning to MapLibre SDK provides a robust, high-performance, and truly free open-source mapping solution that supports standard map interactions while still allowing for custom state highlighting via GeoJSON layers.

## What Changes

- **SDK Integration**: Replace custom Canvas rendering with MapLibre Compose SDK.
- **Data Format Migration**: Transition from SVG path strings to GeoJSON for state boundaries.
- **UI Enhancement**: Improved map interactions (pan, zoom, tilt) and professional map styling.
- **State Highlighting**: Re-implement state highlighting logic using MapLibre's `FillLayer` and data-driven styling.

## Capabilities

### New Capabilities
- `map-libre-integration`: Configuration and lifecycle management of the MapLibre view.
- `geojson-state-provider`: Logic to convert current state data/bounds into GeoJSON format.

### Modified Capabilities
- `map-india-view`: Update the India map view to use the SDK instead of Canvas.

## Impact

- **UI**: Significant improvement in map quality and interaction.
- **Dependencies**: Removal of `PathParser` dependencies (if any) and addition of MapLibre Compose.
- **Resources**: Replace SVG-based JSON with GeoJSON for better compatibility with Map SDKs.
