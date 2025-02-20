import SwiftUI

struct EventIcon: View {
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

#Preview {
    EventIcon(type: .positiveScore(1, "Best ride ever!", "Awesome raid"))
}
