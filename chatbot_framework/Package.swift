// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chatbot",
    defaultLocalization: "fr",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Chatbot",
            type: .dynamic,
            targets: ["Chatbot"/*, "ChatbotRemoteBinaryPackage"*/]
        ),
    ],
    dependencies: [
        //.package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", from: "3.1.1"),
    ],
    targets: [
        .target(
            name: "Chatbot",
            dependencies: [
                //.product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
            ],
            resources: [.process("Resources")]/*,
            swiftSettings: [
                .define("BUILD_LIBRARIES_FOR_DISTRIBUTION")
            ]*/
        ),
        /*.binaryTarget(
            name: "ChatbotRemoteBinaryPackage",
            url: "http://10.137.40.77:8081/repository/maven-releases/ma/inwi/chatbot-ios/1.0.0/chatbot-ios-1.0.0.zip",
            checksum: "db4cd59d52b2ee074eb15a166d3221750de2cd995bbfb2735d491a7cc1b62aa5"
        ),*/
        .testTarget(
            name: "ChatbotTests",
            dependencies: ["Chatbot"]),
    ]
)
