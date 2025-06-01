# TMNavigation

Modern, type-safe navigation for SwiftUI with Clean Architecture and async support.

> **Important:**
> Always create and inject your TMCoordinator instance via `.environment(\.coordinator, coordinator)` at the app entry point (e.g., in your App or Scene). Do **not** rely on a default value in EnvironmentKey, as TMCoordinator is @MainActor and must be created on the main thread. This ensures thread safety and correct navigation behavior.

A modern, type-safe, and extensible navigation coordinator for SwiftUI apps. Supports generic waypoints, async navigation, and centralized logging.

## Features

- Generic TMCoordinator with type-safe TMWaypoint protocol
- Centralized navigation stack management
- Async navigation methods
- Configurable logging (enabled by default)
- Full SwiftUI and Observation support
- Easy integration with DI containers (e.g., Factory)

## Installation

Add TMNavigation as a Swift Package dependency in Xcode or via `Package.swift`:

```swift
.package(url: "https://github.com/Rayllienstery/TMNavigation.git", from: "1.0.0")
```

## Usage Example

```swift
import TMNavigation

// 1. Define your Waypoint enum in your app:
enum AppWaypoint: TMWaypoint {
    case home, settings, premium
    @MainActor
    func view(coordinator: any TMCoordinatorProtocol) -> AnyView {
        switch self {
        case .home: return AnyView(HomeView())
        case .settings: return AnyView(SettingsView())
        case .premium: return AnyView(PremiumView())
        }
    }
}

// 2. Create a TMCoordinator instance:
let coordinator = TMCoordinator<AppWaypoint>()

// 3. Use in your SwiftUI view:
struct ContentView: View {
    @Bindable var coordinator: TMCoordinator<AppWaypoint>
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            // ...
        }
    }
}

// 4. Navigate:
coordinator.append(.premium)
```

---

## Integration Examples

### Using Factory (Dependency Injection)

```swift
import TMNavigation
import FactoryKit

// 1. Define your Waypoint enum as above

// 2. Register TMCoordinator in Factory
extension Container {
    var coordinator: Factory<TMCoordinator<AppWaypoint>> {
        self { TMCoordinator<AppWaypoint>() }.singleton
    }
}

// 3. Inject TMCoordinator in your View
struct ContentView: View {
    @Injected(\.coordinator) var coordinator: TMCoordinator<AppWaypoint>
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            // ...
        }
    }
}

// 4. Navigate:
coordinator.append(.premium)
```

### Using Environment

```swift
import TMNavigation
import SwiftUI

// 1. Define EnvironmentKey for TMCoordinator
private struct CoordinatorKey: EnvironmentKey {
    static var defaultValue: TMCoordinator<AppWaypoint> {
        fatalError("TMCoordinator must be injected via .environment(\\.coordinator, ...) in App entry point.")
    }
}
extension EnvironmentValues {
    var coordinator: TMCoordinator<AppWaypoint> {
        get { self[CoordinatorKey.self] }
        set { self[CoordinatorKey.self] = newValue }
    }
}

// 2. Pass TMCoordinator via .environment
let coordinator = TMCoordinator<AppWaypoint>()

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.coordinator, coordinator)
        }
    }
}

// 3. Use TMCoordinator in your View
struct ContentView: View {
    @Environment(\.coordinator) var coordinator: TMCoordinator<AppWaypoint>
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            // ...
        }
    }
}

// 4. Navigate:
coordinator.append(.premium)
```

## Quick Start (Minimal Example)

You can use TMNavigation in a minimal SwiftUI app without a coordinator for simple screens or UI testing:

```swift
import SwiftUI

@main
struct TMNavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ScreenAView()
        }
    }
}

public struct ScreenAView: View {
    public init() {}
    public var body: some View {
        Text("A")
            .accessibilityLabel("A")
    }
}

> **Note:** For simple screens or UI tests, you can use a plain SwiftUI view without a navigation coordinator. For advanced navigation flows, use TMCoordinator as described in the main documentation.

## Documentation

- Full API reference and guides: [See DOCC documentation](https://github.com/Rayllienstery/TMNavigation)

## License

MIT
