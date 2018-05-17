// swift-tools-version:4.1

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
