# BeenThere

BeenThere is a native iOS application designed to help you track your travels across India. It provides an interactive map where you can mark visited states and union territories, and view detailed statistics about your regional coverage.

## Features

- **Interactive India Map:** Tap on states and union territories to mark them as visited.
- **Dynamic Stats:** Track your progress with percentage-based coverage for different regions of India (North, South, East, West, Central, and Northeast).
- **Regional Breakdown:** See exactly which states you've visited in each region.
- **Persistence:** Your travel history is saved locally on your device.

## Tech Stack

- **Swift & SwiftUI:** Modern declarative UI.
- **MapKit:** High-performance mapping and GeoJSON rendering.
- **XcodeGen:** Simplified project management and configuration.
- **MVVM Architecture:** Clean separation of concerns for maintainability and testability.

## Project Structure

```text
├── BeenThere/          # Main application code
│   ├── App/            # App entry point and lifecycle
│   ├── Resources/      # Assets and GeoJSON map data
│   └── UI/             # SwiftUI Views, ViewModels, and UI helpers
├── BeenThereTests/     # Unit tests for business logic and ViewModels
├── openspec/           # Specifications and change history (OpenSpec workflow)
├── LICENSE             # MIT License file
└── project.yml         # XcodeGen configuration
```

## Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern:

- **StateVisitManager:** The central source of truth for visited regions, handling persistence via `UserDefaults`.
- **StatsViewModel:** Computes statistics, regional coverage, and progress percentages.
- **IndiaMapView:** A `UIViewRepresentable` wrapper for `MKMapView` that handles GeoJSON rendering and tap interactions.
- **StatsView:** Displays visual representations of travel progress.

## Getting Started

### Prerequisites

- macOS with Xcode 15 or later.
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (can be installed via Homebrew: `brew install xcodegen`).

### Setup

1. Clone the repository.
2. Generate the Xcode project:
   ```bash
   xcodegen generate
   ```
3. Open `BeenThere.xcodeproj` in Xcode.
4. Select a simulator or physical device (iOS 16.0+) and run the app (Cmd+R).

## Development Workflow

This project uses **OpenSpec** for spec-driven development. 

- New features or major changes are first proposed in the `openspec/` directory.
- Use the Gemini CLI commands (if available) to manage the workflow:
    - `/opsx:propose` - Start a new change.
    - `/opsx:apply` - Implement tasks.
    - `/opsx:archive` - Finalize changes.

## Testing

Run unit tests via Xcode (Cmd+U) or using `xcodebuild`:
```bash
xcodebuild test -scheme BeenThere -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Data Sources

The map boundaries are provided by `india_states.geojson` located in the `Resources` directory. This data is used by `IndiaMapView` to render state polygons on the `MKMapView`.

## License

This project is licensed under the MIT License.
