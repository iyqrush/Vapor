// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TILApp",
    products: [
        .library(name: "TILApp", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"), //依赖sqlite
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0"), //依赖mysql
        .package(url: "https://github.com/vapor/leaf.git",from: "3.0.0"), //引入Leaf
    ],
    targets: [
//        .target(name: "App", dependencies: ["FluentSQLite", "Vapor"]),
        .target(name: "App", dependencies: ["FluentMySQL","FluentSQLite", "Vapor", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

