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
4. Select a simulator or physical device and run the app (Cmd+R).

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

## License

This project is licensed under the MIT License.
