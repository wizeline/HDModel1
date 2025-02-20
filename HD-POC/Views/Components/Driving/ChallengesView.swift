import SwiftUI

struct ChallengesView: View {
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

#Preview {
    ChallengesView()
}
