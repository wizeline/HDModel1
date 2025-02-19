//
//  HD_POCApp.swift
//  HD-POC
//
//  Created by Kelderth Krom on 15/02/25.
//

import SwiftUI

@main
struct HD_POCApp: App {
    @State private var showingSafetyAssistant = false
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .onAppear {
                    // Check UserDefaults on app launch
                    let userDefaults = UserDefaults(suiteName: "group.com.Kelderth.HD-POC")
                    if userDefaults?.bool(forKey: "ShowSafetyDialog") == true {
                        showingSafetyAssistant = true
                        userDefaults?.set(false, forKey: "ShowSafetyDialog")
                    }
                }
                .sheet(isPresented: $showingSafetyAssistant) {
                    SafetyDialogView()
                }
                .onOpenURL { url in
                    if url.scheme == "hdapp" && url.host == "safety-assistant" {
                        // Show the safety assistant view/conversation
                        print("Should show safety assistant!")
                        // Here we would trigger showing the conversation view
                    }
                }
        }
    }
}
