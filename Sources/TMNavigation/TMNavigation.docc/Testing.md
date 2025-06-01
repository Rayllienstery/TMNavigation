# Testing

TMNavigation is designed for maximum testability and 100% unit test coverage of business logic and ViewModels.

## Test Coverage

- All ViewModels, business logic, services, use-cases, and protocols must have 100% unit test coverage.
- UI components (Views) do not require unit tests; use SwiftUI Previews and UI tests for validation.

## Test Structure

- Place tests in the `Tests/TMNavigationTests` folder.
- Use the Given-When-Then pattern for test structure.
- Name tests using: `should <expected behavior> when <condition>`.
- Use mocks for dependencies, named with the `Mock` prefix.

## Example

```swift
func test_shouldNavigateToDetails_whenButtonTapped() {
    // Given
    let model = NavigationModel()
    // When
    model.path.append(.details)
    // Then
    XCTAssertEqual(model.path.last, .details)
}
```

## See Also

- <doc:Architecture>
- <doc:UsageExamples>
