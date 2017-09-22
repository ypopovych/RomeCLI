// swift-tools-version:4.0
//
// Package.swift
// RomeCLI
//
// Created by Yehor Popovych on 22/09/2017.
// Copyright © 2017 Yehor Popovych. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "RomeCLI",
    products: [
        .executable(name: "romecli", targets: ["RomeCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ypopovych/RomeKit.git", from: "0.4.0"),
        .package(url: "https://github.com/jatoben/CommandLine.git", .branch("master"))
    ],
    targets: [
        .target(name: "RomeCLI", dependencies: ["RomeKit", "CommandLine"])
    ]
)
