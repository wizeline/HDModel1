import SwiftUI

struct TierStatusView: View {
    let currentTier: String
    let points: Int
    let nextTierPoints: Int
    
    var body: some View {
        VStack(spacing: 16) {
            // MARK: - Current Tier Badge
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
            
            // MARK: - Progress to next tier
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

#Preview {
    TierStatusView(currentTier: "Master", points: 100, nextTierPoints: 200)
}
