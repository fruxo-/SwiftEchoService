// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftEcho",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "SwiftEchoServer",
                    targets: ["SwiftEchoServer"]
        ),
        .executable(name: "SwiftEchoClient",
                    targets: ["SwiftEchoClient"]
        ),
        .library(name: "SwiftEchoModel",
                 type: .static,
                 targets: ["SwiftEchoModel"])
    ],
    dependencies: [
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.0.0-alpha.12"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftEchoModel",
            dependencies: [
              .product(name: "GRPC", package: "grpc-swift")
            ],
            path: "Sources/Model"
        ),
        .target(
            name: "SwiftEchoServer",
            dependencies: [
                "SwiftEchoModel"
            ],
            path: "Sources/SwiftEchoServer"
        ),
        .target(
            name: "SwiftEchoClient",
            dependencies: [
                "SwiftEchoModel"
            ],
            path: "Sources/SwiftEchoClient"
        ),
        .testTarget(
            name: "SwiftEchoServerTests",
            dependencies: ["SwiftEchoServer"]
        ),
    ]
)
