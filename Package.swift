// swift-tools-version:4.1

import PackageDescription

// let package = Package(
//     name: "JSONDecodeKit"
// )

let targets:[Target] = [
    .target(name: "JSONDecodeKit")
]

let products: [Product] = [
    .executable(name: "JSONDecodeKit", targets: ["JSONDecodeKit"])
]

let package = Package(
    name: "JSONDecodeKit",
    products: products,
    dependencies: [],
    targets: targets
)
