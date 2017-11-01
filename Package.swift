// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RichString",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "RichString",
            targets: ["RichString"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.1"),
        .package(url: "https://github.com/Quick/Quick.git", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RichString",
            dependencies: [],
            path: "RichString",
            exclude: ["RichString/iOS", "RichString/tvOS", "RichString/watchOS"]),
        .testTarget(
            name: "RichStringTests",
            dependencies: ["RichString", "Quick", "Nimble"],
            path: "RichStringTests",
            exclude: ["RichStringTests/iOS", "RichStringTests/tvOS", "RichStringTests/watchOS"]),
    ],
    swiftLanguageVersions: [4]
)
