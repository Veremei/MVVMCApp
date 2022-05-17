// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "MVVMCApp-danger",
    dependencies: [
      .package(url: "https://github.com/danger/swift.git", from: "3.10.1")
    ],
    targets: [
        // This is just an arbitrary Swift file in our app, that has
        // no dependencies outside of Foundation, the dependencies section
        // ensures that the library for Danger gets build also.
        .target(name: "MVVMCApp-danger",
	dependencies: [
                 .product(name: "Danger", package: "swift")
             ],
	path: "MVVMCApp",
	sources: ["Coordinator/Coordinator.swift"])
    ]
)
