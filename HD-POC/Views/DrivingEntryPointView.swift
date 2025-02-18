//
//  DrivingEntryPointView.swift
//  HD-POC
//
//  Created by Hugo Ramirez on 18/02/25.
//

import SwiftUI

public struct DrivingEntryPointView: View {
    @State private var selectedModal: ModalType?
    @State private var timelineScrollOffset: CGFloat = 0
    
    public var body: some View {
        ZStack {
            // Main Timeline View
            TimelineScrollView()
            
            // Navigation Overlay
            VStack {
                Spacer()
                NavigationBar(selectedModal: $selectedModal)
            }
        }
        .sheet(item: $selectedModal) { modalType in
            switch modalType {
            case .safetyAssistant:
                SafetyAssistantView()
            case .lastRideDetails:
                LastRideDetailsView()
            case .rideRewards:
                RideRewardsView()
            }
        }
    }
}

// MARK: - Supporting Views
private struct TimelineScrollView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<40) { index in
                    TimelineEvent(index: index, isLast: index == 39)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                // Add extra space at the bottom to account for the navigation bar
                Color.clear
                    .frame(height: 150) // Adjust this value as needed
            }
            .padding(.vertical)
        }
        .background(Color(.systemBackground))
        .mask(
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.white)
                LinearGradient(
                    gradient: Gradient(colors: [.white, .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
            }
        )
    }
}

// First, let's create our event models
private enum EventType: Identifiable {
    case positiveScore(Int, String, String)
    case negativeScore(Int, String, String)
    case achievement(AchievementTier, String, String)
    case systemEvent(String, String)
    
    var id: String {
        switch self {
        case .positiveScore(_, let title, _): return "positive_\(title)"
        case .negativeScore(_, let title, _): return "negative_\(title)"
        case .achievement(_, let title, _): return "achievement_\(title)"
        case .systemEvent(let title, _): return "system_\(title)"
        }
    }
}

private enum AchievementTier {
    case beginner
    case intermediate
    case advanced
    
    var icon: String {
        switch self {
        case .beginner: return "medal.fill"
        case .intermediate: return "medal.fill"
        case .advanced: return "medal.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .beginner: return Color(red: 0.8, green: 0.5, blue: 0.2)  // Bronze
        case .intermediate: return Color(red: 0.75, green: 0.75, blue: 0.8)  // Silver
        case .advanced: return Color(red: 1.0, green: 0.84, blue: 0.0)  // Gold
        }
    }
}

private struct TimelineEvent: View {
    let index: Int
    let isLast: Bool
    @State private var isVisible = false
    
    // Mock data with all possible events
    var eventType: EventType {
        [
            // Positive Score Events
            .positiveScore(1000, "Flawless Ride", "Completed a full ride with zero negative events"),
            .positiveScore(750, "Smooth Braking Streak", "No sudden braking for 50 miles"),
            .positiveScore(600, "Perfect Cornering", "100 safe turns without sharp leans"),
            .positiveScore(500, "Speed Limit Mastery", "No speed violations for 100 miles"),
            .positiveScore(400, "Defensive Riding", "AI detects proactive hazard avoidance"),
            .positiveScore(300, "Turn Signal Pro", "Used turn signals correctly 50 times in a row"),
            .positiveScore(250, "Safe Overtaker", "20 controlled and legal overtakes"),
            .positiveScore(200, "Eco Throttle Control", "Maintained fuel-efficient throttle for 50 mi"),
            .positiveScore(150, "Full Gear Compliance", "AI detects full safety gear for 10 rides"),
            .positiveScore(100, "No Sudden Maneuvers", "Completed ride with smooth, stable riding"),
            
            // Negative Score Events
            .negativeScore(-1000, "Severe Crash Event", "AI detects a high-impact crash"),
            .negativeScore(-750, "Dangerous Speeding", "Exceeding speed limit by 30%+ for a long time"),
            .negativeScore(-600, "Hard Braking Event", "AI detects emergency braking multiple times"),
            .negativeScore(-500, "Sharp Lean Warning", "Risky cornering detected at high speed"),
            .negativeScore(-400, "Lane Weaving", "Frequent and unnecessary lane changes"),
            .negativeScore(-300, "Late Night Risk", "Riding in high-risk hours (1 AM – 5 AM)"),
            .negativeScore(-250, "Swerving Event", "Sudden, unsafe directional changes"),
            .negativeScore(-200, "Missing Signals", "Repeated failure to use turn signals"),
            .negativeScore(-150, "Safety Gear Alert", "AI detects missing helmet or gear"),
            .negativeScore(-100, "Cold Engine Risk", "Repeatedly riding with an unwarmed engine"),
            
            // Beginner Achievements
            .achievement(.beginner, "First Ride!", "Completed your first tracked ride"),
            .achievement(.beginner, "Safety First", "Completed a ride with full protective gear"),
            .achievement(.beginner, "Smooth Start", "10 miles without any sudden braking"),
            .achievement(.beginner, "No Speed Demon", "Completed a ride without exceeding limits"),
            .achievement(.beginner, "Corner Rookie", "Successfully completed 10 smooth turns"),
            
            // Intermediate Achievements
            .achievement(.intermediate, "Smooth Operator", "50 miles with no sudden maneuvers"),
            .achievement(.intermediate, "Brake Master", "100 miles with no hard braking"),
            .achievement(.intermediate, "Turn Signal Pro", "Used signals correctly 100 times"),
            .achievement(.intermediate, "Perfect Lanes", "No unnecessary lane changes for 50 miles"),
            .achievement(.intermediate, "Speed Control", "Maintained speed limit for 200 miles"),
            
            // Advanced Achievements
            .achievement(.advanced, "Flawless Mastery", "500 miles with zero negative events"),
            .achievement(.advanced, "Ultimate Defense", "50 successful hazard avoidances"),
            .achievement(.advanced, "Zero to Hero", "50 consecutive rides with no violations"),
            .achievement(.advanced, "Iron Butt", "300-mile ride without violations"),
            .achievement(.advanced, "Safety Legend", "100 rides with perfect AI rating"),
            
            // System Events
            .systemEvent("Safety Assistant", "Voice command: 'Hey HD, activate Safety Assistant'"),
            .systemEvent("Route Update", "AI suggests safer route due to weather"),
            .systemEvent("Gear Check", "AI completed pre-ride safety inspection"),
            .systemEvent("Emergency Contact", "Emergency contact information updated"),
            .systemEvent("System Update", "Safety system firmware updated successfully")
        ][index % 40] // Using 40 to show all events in rotation
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            TimelineLine(isFirst: index == 0, isLast: isLast)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    EventIcon(type: eventType)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        EventTitle(type: eventType)
                        Text("February 20, 2025 • 3:45 PM")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    EventScore(type: eventType)
                }
                
                EventDescription(type: eventType)
                
                if !isLast {
                    Divider()
                        .padding(.top, 8)
                }
            }
            .padding(.vertical, 16)
        }
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.3).delay(Double(index) * 0.1)) {
                isVisible = true
            }
        }
    }
}

private struct EventIcon: View {
    let type: EventType
    
    var body: some View {
        Group {
            switch type {
            case .positiveScore(_, let title, _):
                Rectangle()
                    .fill(Color.black)
                    .overlay(
                        Image(systemName: iconForPositiveEvent(title))
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
            case .negativeScore(_, let title, _):
                Rectangle()
                    .fill(Color.black)
                    .overlay(
                        Image(systemName: iconForNegativeEvent(title))
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
            case .achievement(let tier, _, _):
                Rectangle()
                    .fill(tier.color)
                    .overlay(
                        ZStack {
                            Image(systemName: tier.icon)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            // Small star overlay for medals
                            Image(systemName: "star.fill")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                                .offset(y: -2)
                        }
                    )
            case .systemEvent(let title, _):
                Rectangle()
                    .fill(Color.gray)
                    .overlay(
                        Image(systemName: iconForSystemEvent(title))
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
            }
        }
        .frame(width: 40, height: 40)
    }
    
    private func iconForPositiveEvent(_ title: String) -> String {
        switch title {
        case "Flawless Ride": return "checkmark.circle.fill"
        case "Smooth Braking Streak": return "hand.raised.fill"
        case "Perfect Cornering": return "arrow.turn.right.up"
        case "Speed Limit Mastery": return "gauge.medium"
        case "Defensive Riding": return "shield.fill"
        case "Turn Signal Pro": return "arrow.right"
        case "Safe Overtaker": return "arrow.left.and.right.circle"
        case "Eco Throttle Control": return "leaf.fill"
        case "Full Gear Compliance": return "person.fill.checkmark"
        case "No Sudden Maneuvers": return "arrow.up.and.down"
        default: return "plus.circle.fill"
        }
    }
    
    private func iconForNegativeEvent(_ title: String) -> String {
        switch title {
        case "Severe Crash Event": return "exclamationmark.octagon.fill"
        case "Dangerous Speeding": return "gauge.high"
        case "Hard Braking Event": return "exclamationmark.circle.fill"
        case "Sharp Lean Warning": return "arrow.up.left.and.arrow.down.right"
        case "Lane Weaving": return "arrow.left.and.right"
        case "Late Night Risk": return "moon.fill"
        case "Swerving Event": return "arrow.up.and.down"
        case "Missing Signals": return "arrow.right.slash"
        case "Safety Gear Alert": return "person.crop.circle.badge.exclamationmark"
        case "Cold Engine Risk": return "thermometer.snowflake"
        default: return "exclamationmark.triangle.fill"
        }
    }
    
    private func iconForSystemEvent(_ title: String) -> String {
        switch title {
        case "Safety Assistant": return "mic.circle.fill"
        case "Route Update": return "map.fill"
        case "Gear Check": return "checklist"
        case "Emergency Contact": return "phone.circle.fill"
        case "System Update": return "arrow.triangle.2.circlepath"
        default: return "gear.circle.fill"
        }
    }
}

private struct EventTitle: View {
    let type: EventType
    
    var body: some View {
        Text(title)
            .font(.headline)
    }
    
    private var title: String {
        switch type {
        case .positiveScore(_, let title, _): return title
        case .negativeScore(_, let title, _): return title
        case .achievement(_, let title, _): return title
        case .systemEvent(let title, _): return title
        }
    }
}

private struct EventScore: View {
    let type: EventType
    
    // Arrays of emojis for each achievement tier
    private let beginnerEmojis = ["🎯", "👏", "💫", "🌟", "✨"]
    private let intermediateEmojis = ["🔥", "💪", "⚡️", "🎨", "🚀"]
    private let advancedEmojis = ["👑", "🏆", "💎", "🌈", "⭐️"]
    
    var body: some View {
        switch type {
        case .positiveScore(let score, _, _):
            Text("+\(score)")
                .font(.headline.bold())
                .foregroundColor(.black)
        case .negativeScore(let score, _, _):
            Text("\(score)")
                .font(.headline.bold())
                .foregroundColor(.black)
        case .achievement(let tier, _, _):
            Text(getRandomEmoji(for: tier))
                .font(.title2)
        default:
            EmptyView()
        }
    }
    
    private func getRandomEmoji(for tier: AchievementTier) -> String {
        let emojis: [String]
        switch tier {
        case .beginner:
            emojis = beginnerEmojis
        case .intermediate:
            emojis = intermediateEmojis
        case .advanced:
            emojis = advancedEmojis
        }
        return emojis[Int.random(in: 0..<emojis.count)]
    }
}

private struct EventDescription: View {
    let type: EventType
    
    var body: some View {
        Text(description)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    
    private var description: String {
        switch type {
        case .positiveScore(_, _, let desc): return desc
        case .negativeScore(_, _, let desc): return desc
        case .achievement(_, _, let desc): return desc
        case .systemEvent(_, let desc): return desc
        }
    }
}

private struct TimelineLine: View {
    let isFirst: Bool
    let isLast: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            if !isFirst {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 1)
                    .frame(height: 20)
            }
            
            if isFirst {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            } else if isLast {
                Image(systemName: "arrow.down.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            } else {
                Circle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
            }
            
            if !isLast {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 1)
                    .frame(maxHeight: .infinity)
                    .frame(height: 100)
            }
        }
    }
}

private struct StatView: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                Text(value)
                    .font(.system(.subheadline, design: .default))
            }
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

private struct NavigationBar: View {
    @Binding var selectedModal: ModalType?
    
    var body: some View {
        HStack(spacing: 20) {
            NavigationButton(
                icon: "shield.fill",
                title: "Safety",
                color: .black
            ) {
                selectedModal = .safetyAssistant
            }
            
            NavigationButton(
                icon: "clock.fill",
                title: "Last Ride",
                color: .black
            ) {
                selectedModal = .lastRideDetails
            }
            
            NavigationButton(
                icon: "star.fill",
                title: "Rewards",
                color: .orange
            ) {
                selectedModal = .rideRewards
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 5)
        )
        .padding()
    }
}

private struct NavigationButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Rectangle()
                    .fill(color)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    )
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}

// MARK: - Supporting Types
private enum ModalType: Identifiable {
    case safetyAssistant
    case lastRideDetails
    case rideRewards
    
    var id: Self { self }
}

// MARK: - Modal Views (Placeholder)
private struct SafetyAssistantView: View {
    var body: some View {
        Text("Safety Assistant")
    }
}

private struct LastRideDetailsView: View {
    var body: some View {
        Text("Last Ride Details")
    }
}

private struct RideRewardsView: View {
    var body: some View {
        Text("Ride Rewards")
    }
}

#Preview {
    DrivingEntryPointView()
}
