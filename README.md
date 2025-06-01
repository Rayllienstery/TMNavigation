# TMNavigation

Modern, type-safe navigation for SwiftUI with Clean Architecture and async support.

> **Important:**
> In production, always inject your TMCoordinator instance via `.environment(\.coordinator, coordinator)` at the app entry point (e.g., in your App or Scene). This guarantees that all views in your app use the same coordinator instance. The `defaultValue` in EnvironmentKey is only a fallback for SwiftUI previews and tests—**do not rely on it in real app flows**. Never override the coordinator in child views.

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
import SwiftUI

@main
struct TMArchitectureImplementationApp: App {
  let coordinator = TMCoordinator<AppWaypoint>()

  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $coordinator.navigationPath) {
        TaskListView()
      }
      .environment(\.coordinator, coordinator)
      .navigationDestination(for: TMNavigationDestination.self) { destination in
        destination.view
      }
    }
  }
}

private struct CoordinatorKey: EnvironmentKey {
  @MainActor
  static var defaultValue: TMCoordinator<AppWaypoint> {
    TMCoordinator<AppWaypoint>() // Safe fallback for previews and tests
  }
}

extension EnvironmentValues {
  var coordinator: TMCoordinator<AppWaypoint> {
    get { self[CoordinatorKey.self] }
    set { self[CoordinatorKey.self] = newValue }
  }
}
```

- **Inject the coordinator only once at the top level (App/Scene).**
- **Do not override .environment(\.coordinator, ...) in child views.**
- The defaultValue is a safe fallback for SwiftUI previews and tests, but in production you should always inject your coordinator explicitly.
- **In this architecture, navigationPath contains TMNavigationDestination objects, so .navigationDestination must be for TMNavigationDestination.**

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
        TMCoordinator<AppWaypoint>() // Safe fallback for previews and tests
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
