// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonKit",
	platforms: [
		.iOS(.v16),
		.macOS(.v13),
		.macCatalyst(.v16),
		.watchOS(.v9),
		.tvOS(.v16)
	],
    products: [
		.library(name: "CommonCoreData", targets: ["CommonCoreData"]),
        .library(name: "CommonFoundation", targets: ["CommonFoundation"]),
		.library(name: "CommonHaptics", targets: ["CommonHaptics"]),
		.library(name: "CommonOSLog", targets: ["CommonOSLog"]),
		.library(name: "CommonSwiftUI", targets: ["CommonSwiftUI"]),
    ],
    dependencies: [],
    targets: [
		.target(name: "CommonCoreData", dependencies: [], path: "Sources/CoreData"),
        .target(name: "CommonFoundation", dependencies: [], path: "Sources/Foundation"),
		.target(name: "CommonHaptics", dependencies: [], path: "Sources/Haptics"),
		.target(name: "CommonOSLog", dependencies: [], path: "Sources/OSLog"),
		.target(name: "CommonSwiftUI", dependencies: [], path: "Sources/SwiftUI"),
    ]
)
