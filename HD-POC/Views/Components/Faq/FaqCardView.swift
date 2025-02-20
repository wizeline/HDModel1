import SwiftUI

struct FaqCardView: View {
    let faq: FaqItem
    let isExpanded: Bool
    let onTap: () -> Void
    @State private var hover = false
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(faq.question)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.orange)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .scaleEffect(hover ? 1.2 : 1.0)
                }
                
                if isExpanded {
                    Divider()
                        .background(Color.orange.opacity(0.3))
                    
                    Text(faq.answer)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
        }
        .groupBoxStyle(CustomGroupBoxStyle())
        .onTapGesture(perform: onTap)
        .onHover { isHovered in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                hover = isHovered
            }
        }
        .scaleEffect(hover ? 1.02 : 1.0)
    }
}

#Preview {
    FaqCardView(
        faq: FaqItem(
            question: "How is the weather today?",
            answer: "It is sunny and warm today.",
            keywords: ["sunny", "warm"]
        ),
        isExpanded: false,
        onTap: noAction
    )
    
    FaqCardView(
        faq: FaqItem(
            question: "How is the weather today?",
            answer: "It is sunny and warm today.",
            keywords: ["sunny", "warm"]
        ),
        isExpanded: true,
        onTap: noAction
    )
}
