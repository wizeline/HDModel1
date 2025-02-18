//
//  Intents.swift
//  HD-POC
//
//  Created by Kelderth Krom on 17/02/25.
//

import AppIntents

struct SpeechAppShortcutProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
        AppShortcut(
            intent: OpenScreenIntent(),
            phrases: [
                "Open \(.applicationName) with custom screen"
            ],
            shortTitle: "Open HD-POC App",
            systemImageName: "popcorn.fill"
        ),
        AppShortcut(
            intent: OpenProfileIntent(),
            phrases: [
                "Open my \(.applicationName) profile"
            ],
            shortTitle: "Open my profile in HD-POC",
            systemImageName: "popcorn.fill"
        ),
        AppShortcut(
            intent: OpenFaqIntent(),
            phrases: [
                "Open my \(.applicationName) frequently asked questions"
            ],
            shortTitle: "Open my Frequent Asked Questions in HD-POC",
            systemImageName: "popcorn.fill"
        )
        ]
    }
}

struct OpenScreenIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Speech Screen"

    static var openAppWhenRun: Bool = true

    @Parameter(
        title: "HD Tab Content",
        requestDisambiguationDialog: "Which Section would you like to open?"
    )
    var appTab: Tab

    func perform() async throws -> some IntentResult {
        NavigationRouter.shared.push(appTab, screen: nil)

        return .result()
    }
}

struct OpenProfileIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Profile"
    
    static var openAppWhenRun: Bool = true
    
    func perform() async throws -> some IntentResult {
        NavigationRouter.shared.push(.profile, screen: nil)
        
        return .result()
    }
}

struct OpenFaqIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Faq"
    
    static var openAppWhenRun: Bool = true
    
    func perform() async throws -> some IntentResult {
        NavigationRouter.shared.isFaqVisible.toggle()
        
        return .result()
    }
}
