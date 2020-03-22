import ProjectDescription
let project = Project(name: "Istvan Sky",
                      organizationName: "Nicolae Ghimbovschi",
                      targets: [
                        Target(name: "IstvanSky",
                               platform: .iOS,
                               product: .app,
                               bundleId: "com.istvansky.app.ios",
                               infoPlist: "Istvan Sky/Info.plist",
                               sources: ["Istvan Sky/**"],
                               resources: [
                                "Istvan Sky/Resources/GoogleService-Info.plist",
                                .glob(pattern: "Istvan Sky/Resources/*.xcassets"),
                                .glob(pattern: "Istvan Sky/Resources/Base.lproj/**"),
                                .folderReference(path: "Istvan Sky/Resources/appdata")
                               ],
                               dependencies: [
                                    .target(name: "NSE")
                               ],
                               // entitlements: "Istvan Sky/Istvan Sky.entitlements",
                               settings: Settings(base: [
                                  "MARKETING_VERSION": .string("1.1"), 
                                  "CURRENT_PROJECT_VERSION": .string("1"),
                                  "CODE_SIGN_ENTITLEMENTS": .string("Istvan Sky/Istvan Sky.entitlements")])
                              ),
                        Target(name: "NSE",
                               platform: .iOS,
                               product: .appExtension,
                               bundleId: "com.istvansky.app.ios.NSE",
                               infoPlist: "NSE/Info.plist",
                               sources: ["NSE/**"],
                               settings: Settings(base: [
                                  "MARKETING_VERSION": .string("1.1"), 
                                  "CURRENT_PROJECT_VERSION": .string("1")])
                        ),
                        Target(name: "IstvanSkyTests",
                               platform: .iOS,
                               product: .unitTests,
                               bundleId: "com.istvansky.app.ios.tests",
                               infoPlist: "Istvan SkyTests/Info.plist",
                               sources: ["Istvan SkyTests/**"],
                               dependencies: [
                                    .target(name: "IstvanSky")
                               ]),
                        Target(name: "IstvanSkyUITests",
                               platform: .iOS,
                               product: .uiTests,
                               bundleId: "com.istvansky.app.ios.uitests",
                               infoPlist: "Istvan SkyUITests/Info.plist",
                               sources: ["Istvan SkyUITests/**"],
                               dependencies: [
                                    .target(name: "IstvanSky")
                               ])

                      ],
                      additionalFiles: [
                                 "Istvan Sky/Istvan Sky.entitlements"
                      ]
)