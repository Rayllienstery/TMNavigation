import SwiftUI

/// A wrapper for navigation destinations in TMNavigation.
///
/// `TMNavigationDestination` is used to store type-erased SwiftUI views (`AnyView`)
/// in the navigation path. Each destination is uniquely identified by a UUID.
///
/// Example:
/// ```swift
/// let destination = TMNavigationDestination(view: AnyView(MyView()))
/// ```
public struct TMNavigationDestination: Identifiable, Equatable, Hashable {
  /// The unique identifier for the navigation destination.
  public let id: UUID

  /// The type-erased SwiftUI view for the destination.
  public let view: AnyView

  /// Creates a new navigation destination with the given view.
  ///
  /// - Parameter view: The SwiftUI view to display at this destination.
  public init(view: AnyView) {
    self.id = UUID()
    self.view = view
  }

  /// Creates a new navigation destination with the given id and view.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the destination.
  ///   - view: The SwiftUI view to display at this destination.
  public init(id: UUID, view: AnyView) {
    self.id = id
    self.view = view
  }

  /// Compares two navigation destinations for equality.
  ///
  /// - Parameters:
  ///   - lhs: The first destination.
  ///   - rhs: The second destination.
  /// - Returns: `true` if the destinations have the same id.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }

  /// Hashes the essential components of the destination.
  ///
  /// - Parameter hasher: The hasher to use.
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
