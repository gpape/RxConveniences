// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxConveniences",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RxConveniences",
            targets: ["RxConveniences"]),
    ],
    dependencies: [
        .package(url: "https://github.com/gpape/CollectiveSwift.git", from: "2.1.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RxConveniences",
            dependencies: [
                .product(name: "CollectiveSwift", package: "CollectiveSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxSwift", package: "RxSwift")
            ]),
        .testTarget(
            name: "RxConveniencesTests",
            dependencies: [
                "RxConveniences",
                .product(name: "RxTest", package: "RxSwift")
            ]),
    ]
)
