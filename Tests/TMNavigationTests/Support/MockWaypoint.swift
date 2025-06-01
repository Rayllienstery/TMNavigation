import SwiftUI

@testable import TMNavigation

/// Mock implementation of TMWaypoint for unit tests.
enum MockWaypoint: TMWaypoint {
  case screenA, screenB
  case deepLink(String)

  @MainActor
  func view(coordinator: any TMCoordinatorProtocol) -> AnyView {
    switch self {
    case .screenA: return AnyView(Text("A"))
    case .screenB: return AnyView(Text("B"))
    case .deepLink(let value): return AnyView(Text("Deep: \(value)"))
    }
  }
}
