import SwiftUI

struct ChallengeCard: View {
    let title: String
    let description: String
    let reward: String
    let timeLeft: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Text("+\(reward)p")
                    .font(.subheadline.bold())
                    .foregroundColor(.orange)
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "clock.fill")
                    .font(.caption)
                Text(timeLeft)
                    .font(.caption)
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.black.opacity(0.05))
    }
}

#Preview {
    ChallengeCard(title: "Awesomeness", description: "Best ride ever", reward: "500p", timeLeft: "20m")
}
