import PackageDescription

var package = Package(
    name: "Redscript",
    targets: [
        Target(name: "Redscript")
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/crypto.git", majorVersion: 1),
        .Package(url: "https://github.com/czechboy0/Redbird.git", majorVersion: 0, minor: 10)
        ]
)

let lib = Product(name: "Redscript", type: .Library(.Dynamic), modules: "Redscript")
