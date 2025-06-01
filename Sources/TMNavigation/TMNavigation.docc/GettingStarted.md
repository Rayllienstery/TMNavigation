# Getting Started

Learn how to integrate and use TMNavigation in your SwiftUI project.

## Minimal Example (No Coordinator)

For simple screens or UI tests, you can use a plain SwiftUI view without a navigation coordinator:

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
```

> For advanced navigation flows, use TMCoordinator as described below.

## Installation

1. Add TMNavigation as a Swift Package dependency in Xcode or via `Package.swift`:

   ```swift
   .package(url: "https://github.com/your-org/TMNavigation.git", from: "1.0.0")
   ```

2. Import TMNavigation in your SwiftUI files:

   ```swift
   import TMNavigation
   ```

## Basic Usage

1. Create your navigation model using `@Observable`:

   ```swift
   @Observable final class NavigationModel {
       var path: [Route] = []
   }
   ```

2. Use the model in your root view:

   ```swift
   struct ContentView: View {
       let model: NavigationModel
       var body: some View {
           NavigationStack(path: $model.path) {
               // ...
           }
       }
   }
   ```

## Requirements

- Swift 5.10+
- SwiftUI (iOS 17+, macOS 14+)

## Next Steps

- See <doc:UsageExamples> for advanced usage.
- See <doc:Architecture> for architectural details.
