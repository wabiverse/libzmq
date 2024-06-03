// swift-tools-version:5.10
import PackageDescription

let package = Package(
  name: "libzmq",
  products: [
    .library(
      name: "libzmq",
      targets: ["zmq", "libzmq"]
    ),
  ],
  dependencies: [
    // Add any dependencies here
  ],
  targets: [
    .target(
      name: "libzmq",
      dependencies: []
    ),
    .target(
      name: "zmq",
      dependencies: [
        .target(name: "libsodium"),
      ],
      path: ".",
      sources: ["src"],
      publicHeadersPath: "include"
    ),
    .systemLibrary(
      name: "libsodium", 
      pkgConfig: "libsodium",
      providers: [
        .apt(["libsodium-dev"]),
        .yum(["libsodium-devel"]),
        .brew(["libsodium"]),
      ]
    ),
  ]
)
