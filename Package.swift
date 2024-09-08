// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "CodingChallenge",
    products: [
        // Library product for core logic
        .library(
            name: "CodingChallenge",
            targets: ["CodingChallenge"]
        ),
        // Executable product
        .executable(
            name: "CodingChallengeExecutable",
            targets: ["CodingChallengeExecutable"]
        ),
    ],
    targets: [
        // Library target containing the core logic
        .target(
            name: "CodingChallenge",
            path: "Sources/CodingChallenge"
        ),
        // Executable target
        .executableTarget(
            name: "CodingChallengeExecutable",
            dependencies: ["CodingChallenge"],
            path: "Sources/CodingChallengeExecutable"
        ),
        // Test target for the library
        .testTarget(
            name: "CodingChallengeTests",
            dependencies: ["CodingChallenge"],
            path: "Tests"
        ),
    ]
)
