// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Shared",
            targets: ["Shared"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            exact: "5.0.1"
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift.git",
            exact: "6.6.0"
        ),
        .package(
            url: "https://github.com/pixeldock/RxAppState.git",
            exact: "1.7.0"
        ),
        .package(
            url: "https://github.com/devxoul/Then",
            exact: "3.0.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Shared",
            dependencies: [
                "SnapKit",
                "Then",
                "RxSwift",
                "RxAppState",
                .product(name: "RxCocoa", package: "RxSwift")
            ])
    ]
)
