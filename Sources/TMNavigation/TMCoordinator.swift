import Observation
import SwiftUI
import os

private let navigationLogger = Logger(subsystem: "TMNavigation", category: "Navigation")

/// A centralized navigation coordinator for TMNavigation.
///
/// `TMCoordinator` manages the navigation stack and routing between screens.
/// It is generic over a `TMWaypoint` type, supports async navigation, and provides configurable logging.
///
/// Example:
/// ```swift
/// let coordinator = TMCoordinator<AppWaypoint>()
/// coordinator.append(.home)
/// ```
@MainActor @Observable
public final class TMCoordinator<Waypoint: TMWaypoint>: TMCoordinatorProtocol {
  /// The navigation path stack for SwiftUI NavigationStack.
  public var navigationPath: NavigationPath = .init()

  /// Enable or disable logging. Default is true.
  public var isLoggingEnabled: Bool = true

  /// Creates a new instance of TMCoordinator.
  ///
  /// - Note: The coordinator is generic over a `Waypoint` type.
  public init() {}

  /// Navigate to a new destination (Waypoint).
  ///
  /// - Parameter waypoint: The destination waypoint to navigate to.
  /// - Important: This method is async and updates the navigation stack.
  /// - Example:
  ///   ```swift
  ///   coordinator.append(.details)
  ///   ```
  public func append(_ waypoint: Waypoint) {
    if isLoggingEnabled {
      navigationLogger.info("➡️ Routing: \(String(describing: waypoint))")
    }
    let destination = TMNavigationDestination(view: waypoint.view(coordinator: self))
    self.navigationPath.append(destination)
  }

  /// Navigate back by removing the last destination from the stack.
  ///
  /// - Note: Does nothing if the stack is empty.
  public func navigateBack() {
    if isLoggingEnabled {
      navigationLogger.info("⬅️ Navigate back")
    }
    if !navigationPath.isEmpty {
      navigationPath.removeLast()
    }
  }

  /// Navigate to the root by clearing the navigation stack.
  ///
  /// - Note: Removes all destinations from the stack.
  public func navigateToRoot() {
    if isLoggingEnabled {
      navigationLogger.info("🏠 Navigate to root")
    }
    if !navigationPath.isEmpty {
      navigationPath.removeLast(navigationPath.count)
    }
  }
}
