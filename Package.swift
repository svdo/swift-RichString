import PackageDescription

let package = Package(
    name: "RichString",
    exclude: ["Pods",
              "Demo_iOS", "Demo_macOS",
              "RichString/iOS", "RichString/macOS",
              "RichStringTests",
              "RichString.xcworkspace", "RichString.xcodeproj"]
)
