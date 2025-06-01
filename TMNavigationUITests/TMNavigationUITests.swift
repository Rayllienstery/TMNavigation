import XCTest

final class TMNavigationUITests: XCTestCase {
  func test_shouldDisplayAccessibilityLabel_whenScreenAIsShown() {
    let app = XCUIApplication()
    app.launch()

    // Ищем элемент с accessibilityLabel "A"
    let labelA = app.staticTexts["A"]

    // Проверяем, что элемент существует
    XCTAssertTrue(labelA.exists, "Элемент с accessibilityLabel 'A' должен быть на экране")
  }
}
