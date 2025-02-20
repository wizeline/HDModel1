import SwiftUI

struct PerkCard: View {
    let icon: String
    let title: String
    let description: String
    @State private var isPulsing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
                .scaleEffect(isPulsing ? 1.2 : 1.0)
                .opacity(isPulsing ? 0.7 : 1.0)
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true)
                    ) {
                        isPulsing = true
                    }
                }
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
    }
}

#Preview {
    PerkCard(icon: "helmet", title: "Safty", description: "Safety comes first!")
}
