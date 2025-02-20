import SwiftUI

struct MessageBubble: View {
    let message: String
    let isHD: Bool
    let showingSafari: Binding<Bool>?
    
    var body: some View {
        HStack {
            if isHD { Spacer() }
            
            VStack(alignment: isHD ? .trailing : .leading, spacing: 4) {
                if message.contains("📎") {
                    Text(message.split(separator: "\n\n")[0])
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isHD ? Color.black.opacity(0.05) : Color.orange)
                        )
                        .foregroundColor(isHD ? .primary : .white)
                    
                    Button(action: {
                        showingSafari?.wrappedValue = true
                    }) {
                        Text("📎 Policy_Details.pdf")
                            .underline()
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                    .foregroundColor(.orange)
                } else {
                    Text(message)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isHD ? Color.black.opacity(0.05) : Color.orange)
                        )
                        .foregroundColor(isHD ? .primary : .white)
                }
            }
            
            if !isHD { Spacer() }
        }
    }
}

#Preview {
    MessageBubble(message: "Custom Question", isHD: false, showingSafari: .constant(false))
    MessageBubble(message: "Custom response", isHD: true, showingSafari: .constant(false))
}
