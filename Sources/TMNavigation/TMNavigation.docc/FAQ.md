# FAQ

Frequently Asked Questions about TMNavigation.

## How do I add a new navigation flow?

Extend your navigation model and add new cases to your route enum. Update your navigation destinations accordingly.

## How do I test navigation logic?

Write unit tests for your navigation model and use dependency injection for testability. See <doc:Testing>.

## Does TMNavigation support deep linking?

Yes, you can implement deep linking by updating the navigation model's path based on incoming URLs.

## How do I ensure accessibility?

Use `.accessibilityLabel`, `.accessibilityHint`, and support Dynamic Type in all views.

## What platforms are supported?

iOS 17+, macOS 14+, visionOS 1+, tvOS 17+.

## How do I contribute?

Fork the repository, create a feature branch, and submit a pull request with tests and documentation.
