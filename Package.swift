// swift-tools-version:5.10
import PackageDescription

let package = Package(
  name: "libzmq",
  products: [
    .library(
      name: "libzmq",
      targets: ["libzmq"]),
  ],
  dependencies: [
    // Add any dependencies here
  ],
  targets: [
    .target(
      name: "libzmq",
      dependencies: [])
  ]
)