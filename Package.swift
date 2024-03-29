// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Jailbroken",
            targets: [
                "Jailbroken",
            ]
        ),
        .library(
            name: "CommonUI",
            targets: [
                "CommonUI",
            ]
        ),
        .library(
            name: "DataUtility",
            targets: [
                "DataUtility",
            ]
        ),
        .library(
            name: "Extensions",
            targets: [
                "Extensions",
            ]
        ),
        .library(
            name: "UIExtensions",
            targets: [
                "UIExtensions",
            ]
        ),
        .library(
            name: "LocalData",
            targets: [
                "LocalData",
            ]
        ),
        .library(
            name: "Preview",
            targets: [
                "Preview",
            ]
        ),
        .library(
            name: "UIUtility",
            targets: [
                "UIUtility",
            ]
        ),
        .library(
            name: "Networking",
            targets: [
                "Networking",
            ]
        ),
        .library(
            name: "Zoomable",
            targets: [
                "Zoomable",
            ]
        ),
        .library(
            name: "RxApplifecycle",
            targets: [
                "RxApplifecycle",
            ]
        ),
        .library(
            name: "CustomFoundation",
            targets: [
                "CustomFoundation",
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/evgenyneu/keychain-swift.git",
            .upToNextMajor(from: "19.0.0")
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            .upToNextMajor(from: "5.0.0")
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            .upToNextMajor(from: "5.0.0")
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(
            url: "https://github.com/krzyzanowskim/CryptoSwift",
            .upToNextMajor(from: "1.8.0")
        ),
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
            name: "Extensions",
            dependencies: [
            ],
            path: "Extensions"
        ),
        .target(
            name: "UIExtensions",
            dependencies: [
                "SnapKit",
                "Extensions"
            ],
            path: "UIExtensions"
        ),
        .target(
            name: "LocalData",
            dependencies: [
                .product(name: "KeychainSwift", package: "keychain-swift"),
            ],
            path: "LocalData"
        ),
        .target(
            name: "Preview",
            dependencies: [
            ],
            path: "Preview"
        ),
        .target(
            name: "UIUtility",
            dependencies: [
            ],
            path: "UIUtility"
        ),
        .target(
            name: "Networking",
            dependencies: [
                "Alamofire",
                "Extensions",
            ],
            path: "Networking"
        ),
        .target(
            name: "Zoomable",
            dependencies: [
                "Extensions",
            ],
            path: "Zoomable"
        ),
        .target(
            name: "RxApplifecycle",
            dependencies: [
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift")
            ],
            path: "RxApplifecycle"
        ),
        .target(
            name: "CustomFoundation",
            dependencies: [
                "CryptoSwift"
            ],
            path: "CustomFoundation"
        ),
    ]
)
