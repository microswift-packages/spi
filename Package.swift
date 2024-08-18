// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "spi",
    products: [
        .library(
            name: "spi",
            targets: ["spi"]),
    ],
    dependencies: [
        .package(url: "https://github.com/microswift-packages/hal-baseline", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "spi",
            dependencies: [],
            path: ".",
            sources: ["spi.swift"]),
    ]
)
