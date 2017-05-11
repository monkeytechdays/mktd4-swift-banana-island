import PackageDescription

let package = Package(
    name: "MKTViewer",
    dependencies: [
        .Package(url: "../MKTData", majorVersion: 1),
    ]
)
