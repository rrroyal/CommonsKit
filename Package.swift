// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "CommonKit",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v18),
		.macOS(.v15),
		.macCatalyst(.v18),
		.watchOS(.v11),
		.tvOS(.v18)
	],
	products: [
		.library(name: "CommonFoundation", targets: ["CommonFoundation"]),
		.library(name: "CommonHaptics", targets: ["CommonHaptics"]),
		.library(name: "CommonOSLog", targets: ["CommonOSLog"]),
		.library(name: "CommonSwiftUI", targets: ["CommonSwiftUI"]),
		.library(name: "CommonViews", targets: ["CommonViews"])
	],
	dependencies: [],
	targets: [
		.target(name: "CommonFoundation", dependencies: [], path: "Sources/Foundation"),
		.target(name: "CommonHaptics", dependencies: [], path: "Sources/Haptics"),
		.target(name: "CommonOSLog", dependencies: [], path: "Sources/OSLog"),
		.target(name: "CommonSwiftUI", dependencies: [], path: "Sources/SwiftUI"),
		.target(
			name: "CommonViews",
			dependencies: [
				"CommonFoundation",
				"CommonOSLog"
			],
			path: "Sources/Views"
		)
	]
)
