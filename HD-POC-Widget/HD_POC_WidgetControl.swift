//
//  HD_POC_WidgetControl.swift
//  HD-POC-Widget
//
//  Created by Fabian Romero Sotelo on 18/02/25.
//

import AppIntents
import SwiftUI
import WidgetKit

// Define our control states
struct RiderControls {
    var isRiding: Bool
    var safetyMode: Bool
    var weatherAlert: Bool
}

struct HD_POC_WidgetControl: ControlWidget {
    static let kind: String = "com.Kelderth.HD-POC.HD-POC-Widget2.control"

    var body: some ControlWidgetConfiguration {
        AppIntentControlConfiguration(
            kind: Self.kind,
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "Safety Assistant",
                isOn: value.isSafetyEnabled,
                action: SafetyAssistantIntent()
            ) { isActive in
                ZStack {
                    Label {
                        Text(isActive ? "PROTECTED" : "ACTIVATE")
                            .font(.system(.body, design: .rounded, weight: .bold))
                    } icon: {
                        Image(systemName: isActive ? "shield.checkered.fill" : "shield.slash")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(isActive ? .orange : .secondary)
                    }
                }
                .containerBackground(.clear, for: .widget)
            }
        }
        .displayName("HD Safety Assistant")
        .description("Quick access to HD's AI Safety features")
    }
}

// Simple entry type
struct QuickRideEntry: TimelineEntry {
    let date: Date
    let isRiding: Bool
}

// Provider with explicit Value type
struct Provider: AppIntentControlValueProvider {
    typealias Value = HD_POC_WidgetControl.Value
    
    func previewValue(configuration: RiderConfiguration) -> HD_POC_WidgetControl.Value {
        HD_POC_WidgetControl.Value(isSafetyEnabled: false, safetyMode: true, weatherAlert: true)
    }

    func currentValue(configuration: RiderConfiguration) async throws -> HD_POC_WidgetControl.Value {
        return HD_POC_WidgetControl.Value(isSafetyEnabled: false, safetyMode: true, weatherAlert: true)
    }
}

// Configuration and Intents
struct RiderConfiguration: ControlConfigurationIntent {
    static let title: LocalizedStringResource = "Rider Controls Configuration"
}

struct RideControlIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Toggle Ride Mode"
    
    @Parameter(title: "Ride Mode Active")
    var value: Bool
    
    init() {}
    
    func perform() async throws -> some IntentResult {
        // Add print statement to verify it's being called
        print("Ride mode toggled to: \(value)")
        
        // Here you would typically:
        // 1. Start/stop ride tracking
        // 2. Update app state
        // 3. Trigger notifications
        
        return .result(value: value)  // Return the new state
    }
}

struct SafetyModeIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Toggle Safety Mode"
    
    @Parameter(title: "Safety Mode Active")
    var value: Bool
    
    init() {}
    
    func perform() async throws -> some IntentResult {
        // Here you would implement the safety mode toggle
        return .result()
    }
}

struct WeatherAlertIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Toggle Weather Alerts"
    
    @Parameter(title: "Weather Alerts Active")
    var value: Bool
    
    init() {}
    
    func perform() async throws -> some IntentResult {
        // Here you would implement the weather alerts toggle
        return .result()
    }
}

struct SafetyAssistantIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Toggle Safety Assistant"
    
    @Parameter(title: "Safety Assistant Active")
    var value: Bool
    
    init() {}
    
    func perform() async throws -> some IntentResult {
        print("Safety Assistant Intent triggered!")  // Debug print
        
        // Try using the shared UserDefaults
        let userDefaults = UserDefaults(suiteName: "group.com.Kelderth.HD-POC")
        userDefaults?.set(true, forKey: "ShowSafetyDialog")
        userDefaults?.synchronize()
        
        // Also try notification
        NotificationCenter.default.post(
            name: Notification.Name("ShowSafetyAssistant"), 
            object: nil
        )
        
        return .result(value: value)
    }
}

extension HD_POC_WidgetControl {
    struct Value {
        var isSafetyEnabled: Bool
        var safetyMode: Bool
        var weatherAlert: Bool
    }
}


