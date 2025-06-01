// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "TMNavigation",
  platforms: [
    .iOS(.v17),
    .macOS(.v14)
  ],
  products: [
    .library(
      name: "TMNavigation",
      targets: ["TMNavigation"]
    )
  ],
  targets: [
    .target(
      name: "TMNavigation",
      path: "Sources/TMNavigation"
    ),
    .testTarget(
      name: "TMNavigationTests",
      dependencies: ["TMNavigation"],
      path: "Tests/TMNavigationTests"
    )
  ]
)
