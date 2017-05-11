import PackageDescription

let bigBlueEndPoint = "https://github.com/IBM-Swift"

let package = Package(
    name: "MKTPlayer",
    targets: [
        Target(
            name: "MKTPlayerRunner",
            dependencies: [
                "MKTPlayer"
            ]
        ),
        Target(
            name: "MKTPlayerTests",
            dependencies: [
                "MKTPlayer"
            ]
        )
    ],
    dependencies: [
        .Package(url: "../MKTData", majorVersion: 1),
        .Package(url: "\(bigBlueEndPoint)/Kitura.git", majorVersion: 1),
        .Package(url: "\(bigBlueEndPoint)/Kitura-Request.git", majorVersion: 0),
        .Package(url: "\(bigBlueEndPoint)/HeliumLogger.git", majorVersion: 1)
    ]
)
