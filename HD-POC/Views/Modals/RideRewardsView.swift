import SwiftUI

struct RideRewardsView: View {
    @State private var showContent = false
    @State private var selectedPerk: Int?
    @State private var isPulsing = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    Color.clear.frame(height: 30)
                    
                    // MARK: - Tier Status with animated crown
                    TierStatusView(
                        currentTier: "Gold Rider",
                        points: 2850,
                        nextTierPoints: 3000
                    )
                    .scaleEffect(showContent ? 1 : 0.8)
                    .opacity(showContent ? 1 : 0)
                    
                    // MARK: - Animated perks grid
                    PerksGridView(tier: "Gold Rider")
                        .offset(y: showContent ? 0 : 50)
                        .opacity(showContent ? 1 : 0)
                    
                    // MARK: - Points breakdown with counting animation
                    PointsBreakdownView(safetyScore: 85)
                        .offset(y: showContent ? 0 : 50)
                        .opacity(showContent ? 1 : 0)
                    
                    // MARK: - Upcoming rewards with progress animations
                    UpcomingRewardsView()
                        .offset(y: showContent ? 0 : 50)
                        .opacity(showContent ? 1 : 0)
                    
                    // MARK: - Challenges with time-based animations
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

#Preview {
    RideRewardsView()
}
