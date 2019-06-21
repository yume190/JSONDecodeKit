// swift-tools-version:5.0

import PackageDescription

let targets: [Target] = [
    .target(name: "JSONDecodeKit")
]

let products: [Product] = [
    .library(name: "JSONDecodeKit", type: .static, targets: ["JSONDecodeKit"])
]

let package = Package(
    name: "JSONDecodeKit",
    products: products,
    dependencies: [],
    targets: targets
)
