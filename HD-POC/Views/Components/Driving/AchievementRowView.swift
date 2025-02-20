import SwiftUI

struct AchievementRow: View {
    let title: String
    let description: String
    let icon: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .rotationEffect(.degrees(isSelected ? 90 : 0))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.05))
        )
        .scaleEffect(isSelected ? 1.02 : 1)
    }
}

#Preview {
    AchievementRow(title: "Driving expert", description: "Experience 1000km", icon: "helmet.fill", isSelected: false)
}
