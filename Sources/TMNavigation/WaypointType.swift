import SwiftUI

/// A protocol describing a navigation waypoint for use with TMNavigation.
///
/// Conform your app's navigation enum to `TMWaypoint` to enable type-safe navigation.
/// Each waypoint must be `Hashable` and provide a SwiftUI view for the destination.
///
/// Example:
/// ```swift
/// enum AppWaypoint: TMWaypoint {
///     case home, settings
///     @MainActor
///     func view(coordinator: any TMCoordinatorProtocol) -> AnyView {
///         switch self {
///         case .home: return AnyView(HomeView())
///         case .settings: return AnyView(SettingsView())
///         }
///     }
/// }
/// ```
public protocol TMWaypoint: Hashable {
  /// Returns the SwiftUI view for the given waypoint.
  ///
  /// - Parameter coordinator: The navigation coordinator (for dependency injection).
  /// - Returns: The destination view wrapped in AnyView.
  @MainActor
  func view(coordinator: any TMCoordinatorProtocol) -> AnyView
}
