import SwiftUI

struct FloatingSafetyButton: View {
    @Binding var showingSafetyDialog: Bool
    
    var body: some View {
        Button(action: {
            showingSafetyDialog = true
        }) {
            HStack(spacing: 6) {
                Image(systemName: "exclamationmark.shield.fill")
                    .font(.system(size: 16))
                Text("SAFETY")
                    .font(.caption.bold())
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.8))
                    .shadow(radius: 2)
            )
        }
    }
}

#Preview {
    FloatingSafetyButton(showingSafetyDialog: .constant(false))
}
