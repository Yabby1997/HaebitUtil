import ProjectDescription

let targets: [Target] = [
    Target(
        name: "HaebitUtil",
        platform: .iOS,
        product: .framework,
        bundleId: "com.seunghun.haebitutil",
        deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
        sources: ["HaebitUtil/Sources/**"],
        dependencies: [],
        settings: .settings(
            base: ["SWIFT_STRICT_CONCURRENCY": "complete"]
        )
    ),
    Target(
        name: "HaebitUtilTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.seunghun.haebitutil.tests",
        sources: ["HaebitUtilTests/Sources/**"],
        dependencies: [
            .target(name: "HaebitUtil")
        ],
        settings: .settings(
            base: [
                "DEVELOPMENT_TEAM": "5HZQ3M82FA",
                "SWIFT_STRICT_CONCURRENCY": "complete"
            ],
            configurations: [],
            defaultSettings: .recommended
        )
    ),
    Target(
        name: "HaebitUtilDemo",
        platform: .iOS,
        product: .app,
        bundleId: "com.seunghun.haebitutil.demo",
        deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
        infoPlist: .extendingDefault(
            with: ["UILaunchStoryboardName": "LaunchScreen",]
        ),
        sources: ["HaebitUtilDemo/Sources/**"],
        resources: ["HaebitUtilDemo/Resources/**"],
        dependencies: [
            .target(name: "HaebitUtil")
        ],
        settings: .settings(
            base: [
                "DEVELOPMENT_TEAM": "5HZQ3M82FA",
                "SWIFT_STRICT_CONCURRENCY": "complete"
            ],
            configurations: [],
            defaultSettings: .recommended
        )
    )
]

let project = Project(
    name: "HaebitUtil",
    organizationName: "seunghun",
    targets: targets
)
