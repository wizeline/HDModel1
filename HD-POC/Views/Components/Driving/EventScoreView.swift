import SwiftUI

struct EventScore: View {
    let type: EventType
    
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

#Preview {
    EventScore(type: .positiveScore(1, "Hello", "World"))
}
