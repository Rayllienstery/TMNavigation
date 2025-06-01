import SwiftUI

/// A protocol describing the public API of a navigation coordinator in TMNavigation.
///
/// Use `TMCoordinatorProtocol` for dependency injection, testing, and abstraction.
/// Your app's coordinator should conform to this protocol.
///
/// - Note: The associated type `Waypoint` must conform to `TMWaypoint`.
@MainActor
public protocol TMCoordinatorProtocol: AnyObject {
  /// The type of waypoint used for navigation.
  associatedtype Waypoint: TMWaypoint

  /// The navigation path stack for SwiftUI NavigationStack.
  var navigationPath: NavigationPath { get set }

  /// Enable or disable logging. Default is true.
  var isLoggingEnabled: Bool { get set }

  /// Navigate to a new destination (Waypoint).
  ///
  /// - Parameter waypoint: The destination waypoint to navigate to.
  func append(_ waypoint: Waypoint)

  /// Navigate back by removing the last destination from the stack.
  func navigateBack()

  /// Navigate to the root by clearing the navigation stack.
  func navigateToRoot()
}
