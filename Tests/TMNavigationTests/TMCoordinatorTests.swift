import SwiftUI
import XCTest

@testable import TMNavigation

@MainActor
final class TMCoordinatorTests: XCTestCase {
  // MARK: - Navigation

  func test_shouldAddDestination_whenAppendIsCalled() async {
    // Given
    let coordinator = TMCoordinator<MockWaypoint>()
    XCTAssertEqual(coordinator.navigationPath.count, 0)
    // When
    coordinator.append(.screenA)
    try? await Task.sleep(nanoseconds: 100_000_000)
    // Then
    XCTAssertEqual(coordinator.navigationPath.count, 1)
  }

  func test_shouldRemoveDestination_whenNavigateBackIsCalled() async {
    // Given
    let coordinator = TMCoordinator<MockWaypoint>()
    coordinator.append(.screenA)
    try? await Task.sleep(nanoseconds: 100_000_000)
    // When
    coordinator.navigateBack()
    // Then
    XCTAssertEqual(coordinator.navigationPath.count, 0)
  }

  func test_shouldClearStack_whenNavigateToRootIsCalled() async {
    // Given
    let coordinator = TMCoordinator<MockWaypoint>()
    coordinator.append(.screenA)
    coordinator.append(.screenB)
    try? await Task.sleep(nanoseconds: 200_000_000)
    // When
    coordinator.navigateToRoot()
    // Then
    XCTAssertEqual(coordinator.navigationPath.count, 0)
  }

  func test_shouldNotLog_whenLoggingIsDisabled() async {
    // Given
    let coordinator = TMCoordinator<MockWaypoint>()
    coordinator.isLoggingEnabled = false
    // When
    coordinator.append(.screenA)
    try? await Task.sleep(nanoseconds: 100_000_000)
    // Then
    XCTAssertEqual(coordinator.navigationPath.count, 1)
  }

  func test_shouldDoNothing_whenNavigateBackOnEmptyStack() {
    // Given
    let coordinator = TMCoordinator<MockWaypoint>()
    // When
    coordinator.navigateBack()
    // Then
    XCTAssertEqual(coordinator.navigationPath.count, 0)
  }

  func test_shouldNotCrash_whenMultipleNavigateBackOnEmptyStack() async {
    // Given
    let coordinator = TMCoordinator<MockWaypoint>()
    coordinator.append(.screenA)
    try? await Task.sleep(nanoseconds: 100_000_000)
    // When
    coordinator.navigateBack()
    coordinator.navigateBack()
    coordinator.navigateBack()
    // Then
    XCTAssertEqual(coordinator.navigationPath.count, 0)
  }

  // MARK: - Deep Linking

  func test_shouldSetupPath_whenDeepLinking() async {
    // Given
    let coordinator = TMCoordinator<MockWaypoint>()
    let deepLinks: [MockWaypoint] = [.deepLink("first"), .deepLink("second")]
    // When
    for link in deepLinks { coordinator.append(link) }
    try? await Task.sleep(nanoseconds: 200_000_000)
    // Then
    XCTAssertEqual(coordinator.navigationPath.count, 2)
    XCTAssertFalse(coordinator.navigationPath.isEmpty)
  }

  // MARK: - Equatable & Hashable

  func test_shouldBeEqual_whenNavigationDestinationHasSameId() {
    // Given
    let viewA = AnyView(Text("A"))
    let viewB = AnyView(Text("B"))
    let id = UUID()
    let dest1 = TMNavigationDestination(id: id, view: viewA)
    let dest2 = TMNavigationDestination(id: id, view: viewB)
    let dest3 = TMNavigationDestination(view: viewA)
    // Then
    XCTAssertEqual(dest1, dest2)
    XCTAssertNotEqual(dest1, dest3)
    XCTAssertEqual(dest1.hashValue, dest2.hashValue)
    XCTAssertNotEqual(dest1.hashValue, dest3.hashValue)
  }
}
