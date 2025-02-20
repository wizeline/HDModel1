import Foundation
import SwiftUI

enum AchievementTier {
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
