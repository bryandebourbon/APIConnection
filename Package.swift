// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "APIConnection",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "APIConnection",
            targets: ["APIConnection"]
        ),
    ],
    targets: [
        .target(
            name: "APIConnection",
            dependencies: []
        ),
        .testTarget(
            name: "APIConnectionTests",
            dependencies: ["APIConnection"]
        ),
    ]
)