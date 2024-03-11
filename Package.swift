// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Jailbroken",
            targets: [
                "Jailbroken"
            ]
        ),
        .library(
            name: "CommonUI",
            targets: [
                "CommonUI"
            ]
        ),
        .library(
            name: "DataUtility",
            targets: [
                "DataUtility"
            ]
        ),
        .library(
            name: "Extension",
            targets: [
                "Extension"
            ]
        ),
        .library(
            name: "LocalData",
            targets: [
                "LocalData"
            ]
        ),
        .library(
            name: "Network",
            targets: [
                "Network"
            ]
        ),
        .library(
            name: "Preview",
            targets: [
                "Preview"
            ]
        ),
        .library(
            name: "UIUtility",
            targets: [
                "UIUtility"
            ]
        )
        
    ],
    dependencies: [
        .package(
            url: "https://github.com/evgenyneu/keychain-swift.git",
            exact: "19.0.0"
        ),
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
            name: "Jailbroken",
            dependencies: [
            ],
            path: "Jailbroken"
        ),
        .target(
            name: "CommonUI",
            dependencies: [
            ],
            path: "CommonUI"
        ),
        .target(
            name: "DataUtility",
            dependencies: [
            ],
            path: "DataUtility"
        ),
        .target(
            name: "Extension",
            dependencies: [
            ],
            path: "Extension"
        ),
        .target(
            name: "LocalData",
            dependencies: [
                .product(name: "KeychainSwift", package: "keychain-swift")
            ],
            path: "LocalData"
        ),
        .target(
            name: "Network",
            dependencies: [
                "Shared",
                "DataUtility"
            ],
            path: "Network",
            resources: [
                .process("Sample")
            ]
        ),
        .target(
            name: "Preview",
            dependencies: [
            ],
            path: "Preview"
        ),
        .target(
            name: "Shared",
            dependencies: [
                "SnapKit",
                "Then",
                "RxSwift",
                "RxAppState",
                .product(name: "RxCocoa", package: "RxSwift")
            ],
            path: "Shared"
        ),
        .target(
            name: "UIUtility",
            dependencies: [
            ],
            path: "UIUtility"
        )
    ]
)
