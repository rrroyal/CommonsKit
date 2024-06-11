// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "CommonKit",
	platforms: [
		.iOS(.v17),
		.macOS(.v14),
		.macCatalyst(.v17),
		.watchOS(.v10),
		.tvOS(.v17)
	],
	products: [
		.library(name: "CommonFoundation", targets: ["CommonFoundation"]),
		.library(name: "CommonHaptics", targets: ["CommonHaptics"]),
		.library(name: "CommonOSLog", targets: ["CommonOSLog"]),
		.library(name: "CommonSwiftUI", targets: ["CommonSwiftUI"]),
	],
	dependencies: [],
	targets: [
		.target(name: "CommonFoundation", dependencies: [], path: "Sources/Foundation"),
		.target(name: "CommonHaptics", dependencies: [], path: "Sources/Haptics"),
		.target(name: "CommonOSLog", dependencies: [], path: "Sources/OSLog"),
		.target(name: "CommonSwiftUI", dependencies: [], path: "Sources/SwiftUI"),
	]
)
