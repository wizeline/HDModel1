import SwiftUI

struct PointsBreakdownView: View {
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

#Preview {
    PointsBreakdownView(safetyScore: 2)
}
