import SwiftUI

struct RewardCard: View {
    let icon: String
    let title: String
    let points: String
    let progress: Double
    @State private var showProgress = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.black.opacity(0.1))
                        
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: geometry.size.width * (showProgress ? progress : 0))
                    }
                }
                .frame(height: 4)
                .onAppear {
                    withAnimation(.spring(duration: 1.0)) {
                        showProgress = true
                    }
                }
            }
            
            Text("\(points)p")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.black.opacity(0.05))
    }
}

#Preview {
    RewardCard(icon: "helmet", title: "Champion", points: "300", progress: 250.0)
}
