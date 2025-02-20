import SwiftUI

struct UpcomingRewardsView: View {
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

#Preview {
    UpcomingRewardsView()
}
