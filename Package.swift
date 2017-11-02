// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RichString",
    products: [
        .library(
            name: "RichString",
            targets: ["RichString"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.1"),
        .package(url: "https://github.com/Quick/Quick.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "RichString",
            dependencies: [],
            path: "RichString",
            exclude: ["RichString/iOS", "RichString/tvOS", "RichString/watchOS"]),
        .testTarget(
            name: "RichStringTests",
            dependencies: ["RichString", "Quick", "Nimble"],
            path: "RichStringTests",
            exclude: ["RichStringTests/iOS", "RichStringTests/tvOS", "RichStringTests/watchOS"])
    ],
    swiftLanguageVersions: [4]
)
