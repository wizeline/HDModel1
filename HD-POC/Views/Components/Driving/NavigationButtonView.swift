import SwiftUI

struct NavigationButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Rectangle()
                    .fill(color)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    )
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    NavigationButton(icon: "helmet", title: "Safety", color: .accent, action: noAction)
}
