import PackageDescription

let package = Package(
    name: "OpenCVTest",
    dependencies: [
        .Package(url: "https://github.com/peterentwistle/OpenCVFramework.git", majorVersion: 1)
    ]
)
