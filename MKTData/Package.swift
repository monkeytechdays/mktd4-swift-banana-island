import PackageDescription

let bigBlueEndPoint = "https://github.com/IBM-Swift"

let package = Package(
    name: "MKTData",
    dependencies: [
        .Package(url: "\(bigBlueEndPoint)/SwiftyJSON.git", majorVersion: 15)
    ]
)
