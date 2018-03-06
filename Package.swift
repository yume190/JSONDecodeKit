import PackageDescription

let package = Package(
    name: "JSONDecodeKit",
    products: [
         .library(name: "JSONDecodeKit", type: .automatic, targets: ["JSONDecodeKit"]),
    ],
    targets: [
        .target(
            name: "JSONDecodeKit",
            dependencies: [],
            path: "JSONDecodeKit",
            exclude: [
                "Base.lproj",
                "Info.plist",
                "JSONDecodeKit.h"
            ]
        ),
    ]
)
