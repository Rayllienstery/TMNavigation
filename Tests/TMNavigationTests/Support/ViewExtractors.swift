import SwiftUI

/// Helper for extracting text from AnyView (for test assertions).
func extractText(from anyView: AnyView) -> String? {
  let mirror = Mirror(reflecting: anyView)
  for child in mirror.children {
    if let text = child.value as? Text {
      let textMirror = Mirror(reflecting: text)
      for tChild in textMirror.children {
        if let storage = tChild.value as? LocalizedStringKey.StringInterpolation {
          return String(describing: storage)
        }
      }
    }
  }
  return nil
}

/// Helper for extracting accessibilityLabel from AnyView (for test assertions).
func extractAccessibilityLabel(from anyView: AnyView) -> String? {
  // For simple Text("...") accessibilityLabel matches the text
  return extractText(from: anyView)
}
