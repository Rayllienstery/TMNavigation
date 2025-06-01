# Architecture

TMNavigation is built on Clean Architecture and MVVM principles for maximum modularity, testability, and scalability.

## Layered Structure

- **Presentation Layer:** SwiftUI Views, ViewModels (annotated with `@Observable`). Handles UI, navigation, and user interaction.
- **Domain Layer:** Business logic, use cases, entities, repository protocols, domain errors. No dependencies on UI or infrastructure.
- **Data Layer:** Data sources, repository implementations, mappers, services.

## Key Principles

- **Separation of Concerns:** Each layer has a single responsibility.
- **Dependency Injection:** All dependencies are injected for testability.
- **No force unwrapping or force try.**
- **100% unit test coverage for business logic and ViewModels.**

## Navigation Model Example

```swift
@Observable final class NavigationModel {
    var path: [Route] = []
}
```

## Extensibility

- Add new navigation flows by extending the model and routes.
- Use protocols for abstraction and testability.

## See Also

- <doc:Testing>
- <doc:UsageExamples>
