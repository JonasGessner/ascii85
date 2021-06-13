// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ascii85",
    platforms: [
        .macOS("10.15.4"),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
        .package(url: "https://github.com/pambrozy/Base85", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ascii85",
            dependencies: [
                .product(name: "Base85", package: "Base85"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
    ]
)
