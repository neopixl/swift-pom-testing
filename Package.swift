// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SwiftPOMTesting",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "SwiftPOMTesting", targets: ["SwiftPOMTesting"]),
    ],
    targets: [
        .target(name: "SwiftPOMTesting"),
    ]
)
