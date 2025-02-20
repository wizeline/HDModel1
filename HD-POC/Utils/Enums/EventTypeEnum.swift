import Foundation

enum EventType: Identifiable {
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

extension EventType {
    static var mockEventTypes: [EventType] {
        return [
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
        ]
    }
}
