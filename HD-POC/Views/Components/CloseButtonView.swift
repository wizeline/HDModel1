import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            
            Spacer()
        }
    }
}
#Preview {
    CloseButton()
}
