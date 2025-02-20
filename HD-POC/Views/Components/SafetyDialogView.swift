//
//  SafetyDialogView.swift
//  HD-POC
//
//  Created by Hugo Ramirez on 19/02/25.
//

import SwiftUI

struct SafetyDialogView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentMessageIndex = 0
    @State private var isAnimating = false
    @State private var showingSafari = false

    let conversation: [(speaker: String, message: String)] = [
        ("You", "Hey HD, I need to contact insurance assistance."),
        ("HD", "I'll connect you with our insurance service right away."),
        ("HD", "Connecting to HD Insurance Services..."),
        ("Agent", "Hello, this is Sarah from HD Insurance. How can I help you today?"),
        ("You", "Hi, I've had a minor incident with my bike."),
        ("Agent", "I understand. First, could you confirm your full name?"),
        ("You", "John Smith"),
        ("Agent", "Thank you, John. Could you provide your insurance policy number?"),
        ("You", "Yes, it's HD-2024-789456"),
        ("Agent", "Perfect! I've found your State Farm policy. I can see you have comprehensive coverage. Click the attachment below to view your policy details:\n\n📎 Policy_Details.pdf"),
        ("You", "Yes, I'm safely off the road."),
        ("Agent", "Good. I can see your location. Do you need roadside assistance?"),
        ("You", "Yes, please."),
        ("Agent", "I'm dispatching a tow service to your location. ETA 20 minutes."),
        ("Agent", "Would you like me to arrange a replacement vehicle?"),
        ("You", "No thanks, I have alternative transportation."),
        ("Agent", "Alright. You'll receive an SMS with the tow service details."),
        ("HD", "I've saved this incident report to your account.")
    ]

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Color.clear.frame(height: 30) // Changed from 60 to 30

                // Voice wave animation
                WaveformView(isAnimating: $isAnimating)
                    .frame(height: 60)

                // Conversation
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
                    .onChange(of: currentMessageIndex) { _ in
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
