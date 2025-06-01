import SwiftUI

@testable import TMNavigation

/// Dummy implementation of TMCoordinatorProtocol for unit tests.
final class DummyCoordinator: TMCoordinatorProtocol {
  typealias Waypoint = MockWaypoint
  var navigationPath: NavigationPath = .init()
  var isLoggingEnabled: Bool = false
  func append(_ waypoint: MockWaypoint) {}
  func navigateBack() {}
  func navigateToRoot() {}
}
