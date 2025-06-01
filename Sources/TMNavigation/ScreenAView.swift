import SwiftUI

/// Экран для UI-теста: отображает текст с accessibilityLabel "A"
public struct ScreenAView: View {
  public init() {}
  public var body: some View {
    Text("A")
      .accessibilityLabel("A")
  }
}

#if DEBUG
  #Preview {
    ScreenAView()
  }
#endif
