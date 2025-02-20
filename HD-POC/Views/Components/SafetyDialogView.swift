import SwiftUI

struct SafetyDialogView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentMessageIndex = 0
    @State private var isAnimating = false
    @State private var showingSafari = false

    let conversation: [(speaker: String, message: String)] = Constants.conversation

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Color.clear.frame(height: 30)

                // MARK: - Voice wave animation
                WaveformView(isAnimating: $isAnimating)
                    .frame(height: 60)

                // MARK: - Conversation
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(0...currentMessageIndex, id: \.self) { index in
                                MessageBubble(
                                    message: conversation[index].message,
                                    isHD: conversation[index].speaker == "HD" || conversation[index].speaker == "Agent",
                                    showingSafari: $showingSafari
                                )
                            }
                        }
                        .padding()
                    }
                    .onChange(of: currentMessageIndex) { oldValue, newValue in
                        withAnimation {
                            proxy.scrollTo(currentMessageIndex)
                        }
                    }
                }

                Spacer()
            }

            CloseButton()
        }
        .onAppear {
            isAnimating = true
            animateConversation()
        }
    }

    private func animateConversation() {
        guard currentMessageIndex < conversation.count - 1 else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            currentMessageIndex += 1
            animateConversation()
        }
    }
}
