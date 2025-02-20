import SwiftUI

struct RideAchievementsView: View {
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

#Preview {
    RideAchievementsView()
}
