//
//  DrivingEntryPointView.swift
//  HD-POC
//
//  Created by Hugo Ramirez on 18/02/25.
//

import SwiftUI
import MapKit
import SafariServices

public struct DrivingEntryPointView: View {
    @State private var selectedModal: ModalType?
    @State private var timelineScrollOffset: CGFloat = 0
    @State private var showingSafetyDialog = false
    @State private var showingSoftCollisionDialog = false
    @State private var showingRoadIncidentDialog = false
    
    // Add these properties for the header
    private let username = "John"
    private let score = 2850
    private let rank = "Road Master"
    private let encouragingPhrases = [
        "Keep up the safe riding! 🏍",
        "You're becoming a safety pro! 🌟",
        "Your riding skills are impressive! 💫",
        "Making the roads safer, one ride at a time! 🛣",
        "Your dedication to safety shows! 🎯"
    ]
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // User Header
                UserHeaderView(
                    username: username,
                    score: score,
                    rank: rank,
                    phrase: encouragingPhrases.randomElement() ?? ""
                )
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Main Timeline View
                TimelineScrollView()
            }
            
            // Safety Button (top right)
            VStack {
                HStack {
                    Spacer()
                    // Soft Collision Button
                    Button(action: { showingSoftCollisionDialog = true }) {
                        Image(systemName: "motorcycle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color.yellow)
                                    .shadow(radius: 2)
                            )
                    }
                    .padding(.trailing, 8)
                    
                    // Road Incident Button
                    Button(action: { showingRoadIncidentDialog = true }) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color.red)
                                    .shadow(radius: 2)
                            )
                    }
                    .padding(.trailing, 16)
                }
                .padding(.top, 8)
                Spacer()
                
                NavigationBar(selectedModal: $selectedModal)
            }
        }
        .sheet(item: $selectedModal) { modalType in
            switch modalType {
            case .lastRideDetails:
                LastRideDetailsView()
            case .rideRewards:
                RideRewardsView()
            }
        }
        .sheet(isPresented: $showingSoftCollisionDialog) {
            IncidentReportView()
        }
        .sheet(isPresented: $showingRoadIncidentDialog) {
            EmergencyIncidentView()
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
        case "Missing Signals": return "hold.brakesignal"
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
    case lastRideDetails
    case rideRewards
    
    var id: Self { self }
}

// MARK: - Modal Views (Placeholder)
private struct LastRideDetailsView: View {
    @State private var animateCharts = false
    @State private var showStats = false
    @State private var showAnalysis = false
    @State private var showAchievements = false
    @State private var selectedMetric: SafetyMetric?
    @State private var isSpinning = false
    
    private let metrics = [
        SafetyMetric(name: "Braking", score: 0.9, icon: "hand.raised.fill"),
        SafetyMetric(name: "Cornering", score: 0.75, icon: "arrow.turn.right.up"),
        SafetyMetric(name: "Speed", score: 0.85, icon: "gauge.medium"),
        SafetyMetric(name: "Signals", score: 0.95, icon: "arrow.right"),
        SafetyMetric(name: "Position", score: 0.8, icon: "arrow.left.and.right")
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    Color.clear.frame(height: 30) // Changed from 60 to 30
                    
                    // Animated Score Ring
                    ZStack {
                        Circle()
                            .stroke(Color.black.opacity(0.1), lineWidth: 20)
                        
                        Circle()
                            .trim(from: 0, to: animateCharts ? 0.85 : 0)
                            .stroke(
                                AngularGradient(
                                    colors: [.orange, .orange.opacity(0.5)],
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360)
                                ),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: 4) {
                            Text("85")
                                .font(.system(size: 48, weight: .bold))
                            Text("Safety Score")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Animated achievement stars
                        ForEach(0..<3) { index in
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                                .offset(
                                    x: animateCharts ? 60 * cos(Double(index) * 2 * .pi / 3) : 0,
                                    y: animateCharts ? 60 * sin(Double(index) * 2 * .pi / 3) : 0
                                )
                                .scaleEffect(animateCharts ? 1 : 0)
                                .opacity(animateCharts ? 1 : 0)
                        }
                    }
                    .frame(height: 200)
                    .padding(.top)
                    
                    // Ride Statistics with animated icons
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(metrics) { metric in
                            MetricCard(metric: metric, isSelected: selectedMetric?.id == metric.id)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedMetric = selectedMetric?.id == metric.id ? nil : metric
                                    }
                                }
                                .scaleEffect(showStats ? 1 : 0.8)
                                .opacity(showStats ? 1 : 0)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Ride Route Map
                    VStack(alignment: .leading, spacing: 8) {
                        Text("RIDE ROUTE")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        RideMapView()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                    
                    if showAchievements {
                        RideAchievementsView()
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            
            CloseButton()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.5)) {
                animateCharts = true
            }
            
            withAnimation(.spring().delay(0.3)) {
                showStats = true
            }
            
            withAnimation(.easeOut.delay(0.6)) {
                showAnalysis = true
            }
            
            withAnimation(.spring().delay(0.9)) {
                showAchievements = true
            }
        }
    }
}

private struct SafetyMetric: Identifiable {
    let id = UUID()
    let name: String
    let score: Double
    let icon: String
}

private struct MetricCard: View {
    let metric: SafetyMetric
    let isSelected: Bool
    @State private var isPulsing = false
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.1))
                    .frame(width: 50, height: 50)
                    .scaleEffect(isPulsing ? 1.2 : 1.0)
                    .opacity(isPulsing ? 0.5 : 1.0)
                
                Image(systemName: metric.icon)
                    .font(.title2)
                    .foregroundColor(.orange)
            }
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true)
                ) {
                    isPulsing = true
                }
            }
            
            Text(metric.name)
                .font(.subheadline.bold())
            
            Text("\(Int(metric.score * 100))")
                .font(.title.bold())
                .foregroundColor(.orange)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(isSelected ? 0.05 : 0.02))
        )
        .scaleEffect(isSelected ? 1.05 : 1)
        .animation(.spring(), value: isSelected)
    }
}

private struct RideMapView: View {
    // HD Headquarters coordinates
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 43.0411,  // Milwaukee HD HQ coordinates
            longitude: -87.9677
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )
    
    @State private var isPulsing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("RIDE LOCATION")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ZStack {
                Map(coordinateRegion: $region)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Custom motorcycle marker
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .scaleEffect(isPulsing ? 1.3 : 1.0)
                        .opacity(isPulsing ? 0.5 : 1.0)
                    
                    Image(systemName: "motorcycle.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.orange)
                }
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true)
                    ) {
                        isPulsing = true
                    }
                }
            }
            .frame(height: 200)
            
            // Location details
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.orange)
                    .font(.caption)
                Text("Harley-Davidson HQ • Milwaukee, WI")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

private struct RideAchievementsView: View {
    @State private var selectedAchievement: Int?
    
    let achievements = [
        ("Smooth Operator", "No sudden movements for 15 minutes", "checkmark.circle.fill"),
        ("Signal Master", "Used all turn signals correctly", "arrow.right"),
        ("Speed Demon", "Maintained legal speed limits", "gauge.medium")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("ACHIEVEMENTS")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ForEach(Array(achievements.enumerated()), id: \.offset) { index, achievement in
                AchievementRow(
                    title: achievement.0,
                    description: achievement.1,
                    icon: achievement.2,
                    isSelected: selectedAchievement == index
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedAchievement = selectedAchievement == index ? nil : index
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

private struct AchievementRow: View {
    let title: String
    let description: String
    let icon: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .rotationEffect(.degrees(isSelected ? 90 : 0))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.05))
        )
        .scaleEffect(isSelected ? 1.02 : 1)
    }
}

private struct RideRewardsView: View {
    @State private var showContent = false
    @State private var selectedPerk: Int?
    @State private var isPulsing = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    Color.clear.frame(height: 30) // Changed from 60 to 30
                    
                    // Tier Status with animated crown
                    TierStatusView(
                        currentTier: "Gold Rider",
                        points: 2850,
                        nextTierPoints: 3000
                    )
                    .scaleEffect(showContent ? 1 : 0.8)
                    .opacity(showContent ? 1 : 0)
                    
                    // Animated perks grid
                    PerksGridView(tier: "Gold Rider")
                        .offset(y: showContent ? 0 : 50)
                        .opacity(showContent ? 1 : 0)
                    
                    // Points breakdown with counting animation
                    PointsBreakdownView(safetyScore: 85)
                        .offset(y: showContent ? 0 : 50)
                        .opacity(showContent ? 1 : 0)
                    
                    // Upcoming rewards with progress animations
                    UpcomingRewardsView()
                        .offset(y: showContent ? 0 : 50)
                        .opacity(showContent ? 1 : 0)
                    
                    // Challenges with time-based animations
                    ChallengesView()
                        .offset(y: showContent ? 0 : 50)
                        .opacity(showContent ? 1 : 0)
                }
                .padding()
            }
            
            CloseButton()
        }
        .onAppear {
            withAnimation(.spring(duration: 0.7)) {
                showContent = true
            }
        }
    }
}

private struct TierStatusView: View {
    let currentTier: String
    let points: Int
    let nextTierPoints: Int
    
    var body: some View {
        VStack(spacing: 16) {
            // Current Tier Badge
            ZStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "crown.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
            }
            
            Text(currentTier)
                .font(.title2.bold())
            
            // Progress to next tier
            VStack(spacing: 8) {
                Text("\(nextTierPoints - points) points to next tier")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.black.opacity(0.1))
                        
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: geometry.size.width * (CGFloat(points) / CGFloat(nextTierPoints)))
                    }
                }
                .frame(height: 8)
                .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color.black.opacity(0.05))
    }
}

private struct PerksGridView: View {
    let tier: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("CURRENT PERKS")
                .font(.caption)
                .foregroundColor(.secondary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                PerkCard(
                    icon: "ticket.fill",
                    title: "HD Events Access",
                    description: "Exclusive access to HD riding events"
                )
                
                PerkCard(
                    icon: "wrench.fill",
                    title: "Priority Service",
                    description: "Skip the line at HD service centers"
                )
                
                PerkCard(
                    icon: "percent",
                    title: "Parts Discount",
                    description: "15% off on genuine HD parts"
                )
                
                PerkCard(
                    icon: "person.2.fill",
                    title: "Community Status",
                    description: "Special badge in HD community"
                )
            }
        }
    }
}

private struct PerkCard: View {
    let icon: String
    let title: String
    let description: String
    @State private var isPulsing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
                .scaleEffect(isPulsing ? 1.2 : 1.0)
                .opacity(isPulsing ? 0.7 : 1.0)
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true)
                    ) {
                        isPulsing = true
                    }
                }
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
    }
}

private struct PointsBreakdownView: View {
    let safetyScore: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("POINTS BREAKDOWN")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                PointsRow(
                    title: "Safe Riding Bonus",
                    points: "+500",
                    description: "Maintained 85+ safety score"
                )
                
                PointsRow(
                    title: "Achievement Rewards",
                    points: "+750",
                    description: "Completed 3 achievements"
                )
                
                PointsRow(
                    title: "Streak Bonus",
                    points: "+300",
                    description: "7 days perfect riding"
                )
            }
        }
    }
}

private struct PointsRow: View {
    let title: String
    let points: String
    let description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.bold())
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(points)
                .font(.headline)
                .foregroundColor(.orange)
        }
        .padding()
        .background(Color.black.opacity(0.05))
    }
}

private struct UpcomingRewardsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("UPCOMING REWARDS")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                RewardCard(
                    icon: "gift.fill",
                    title: "HD Leather Jacket",
                    points: "5000",
                    progress: 0.57
                )
                
                RewardCard(
                    icon: "ticket.fill",
                    title: "HD Rally Pass",
                    points: "3500",
                    progress: 0.81
                )
                
                RewardCard(
                    icon: "star.fill",
                    title: "Premium Status",
                    points: "10000",
                    progress: 0.28
                )
            }
        }
    }
}

private struct RewardCard: View {
    let icon: String
    let title: String
    let points: String
    let progress: Double
    @State private var showProgress = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.black.opacity(0.1))
                        
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: geometry.size.width * (showProgress ? progress : 0))
                    }
                }
                .frame(height: 4)
                .onAppear {
                    withAnimation(.spring(duration: 1.0)) {
                        showProgress = true
                    }
                }
            }
            
            Text("\(points)p")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.black.opacity(0.05))
    }
}

private struct ChallengesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("LIMITED TIME CHALLENGES")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                ChallengeCard(
                    title: "Weekend Warrior",
                    description: "Complete 5 safe rides this weekend",
                    reward: "500",
                    timeLeft: "2 days"
                )
                
                ChallengeCard(
                    title: "Night Rider",
                    description: "3 perfect night rides",
                    reward: "750",
                    timeLeft: "5 days"
                )
                
                ChallengeCard(
                    title: "Group Ride Champion",
                    description: "Join 2 group rides",
                    reward: "1000",
                    timeLeft: "1 week"
                )
            }
        }
    }
}

private struct ChallengeCard: View {
    let title: String
    let description: String
    let reward: String
    let timeLeft: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Text("+\(reward)p")
                    .font(.subheadline.bold())
                    .foregroundColor(.orange)
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "clock.fill")
                    .font(.caption)
                Text(timeLeft)
                    .font(.caption)
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.black.opacity(0.05))
    }
}

struct FloatingSafetyButton: View {
    @Binding var showingSafetyDialog: Bool
    
    var body: some View {
        Button(action: {
            showingSafetyDialog = true
        }) {
            HStack(spacing: 6) {
                Image(systemName: "exclamationmark.shield.fill")
                    .font(.system(size: 16))
                Text("SAFETY")
                    .font(.caption.bold())
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.8))
                    .shadow(radius: 2)
            )
        }
    }
}

struct WaveformView: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<10) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.orange)
                    .frame(width: 3)
                    .frame(height: isAnimating ? heights[index] : 10)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }
    
    private let heights: [CGFloat] = [20, 40, 30, 50, 25, 45, 35, 40, 30, 20]
}

struct MessageBubble: View {
    let message: String
    let isHD: Bool
    let showingSafari: Binding<Bool>?
    
    var body: some View {
        HStack {
            if isHD { Spacer() }
            
            VStack(alignment: isHD ? .trailing : .leading, spacing: 4) {
                if message.contains("📎") {
                    Text(message.split(separator: "\n\n")[0])
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isHD ? Color.black.opacity(0.05) : Color.orange)
                        )
                        .foregroundColor(isHD ? .primary : .white)
                    
                    Button(action: {
                        showingSafari?.wrappedValue = true
                    }) {
                        Text("📎 Policy_Details.pdf")
                            .underline()
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                    .foregroundColor(.orange)
                } else {
                    Text(message)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isHD ? Color.black.opacity(0.05) : Color.orange)
                        )
                        .foregroundColor(isHD ? .primary : .white)
                }
            }
            
            if !isHD { Spacer() }
        }
    }
}

private struct UserHeaderView: View {
    let username: String
    let score: Int
    let rank: String
    let phrase: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Greeting and Score
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello, \(username)!")
                        .font(.title2.bold())
                    
                    HStack(spacing: 4) {
                        Text(rank)
                            .font(.subheadline.bold())
                        Text("•")
                            .foregroundColor(.secondary)
                        Text("\(score) pts")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                }
                Spacer()
            }
            
            // Encouraging Phrase
            Text(phrase)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
                .padding(.top, 8)
        }
        .padding(.bottom, 8)
    }
}

// First, let's create a reusable close button
struct CloseButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            
            Spacer()
        }
    }
}

// Add Safari view
struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

#Preview {
    DrivingEntryPointView()
}
