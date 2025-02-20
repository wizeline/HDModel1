import SwiftUI

struct IncidentReportView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentMessageIndex = 0
    @State private var isAnimating = false
    @State private var selectedIncident: IncidentType?
    @State private var additionalMessages: [(speaker: String, message: String)] = []
    
    enum IncidentType: String, CaseIterable {
        case motorFailure = "Motor Failure"
        case minorFall = "Minor Fall"
        case softCollision = "Soft Collision"
        
        var icon: String {
            switch self {
            case .motorFailure: return "engine.combustion.fill"
            case .minorFall: return "person.fill.turn.down"
            case .softCollision: return "motorcycle.fill"
            }
        }
    }
    
    let conversation: [(speaker: String, message: String)] = Constants.incidentConversation
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Color.clear.frame(height: 30)
                
                // Voice wave animation
                WaveformView(isAnimating: $isAnimating)
                    .frame(height: 60)
                
                // Conversation with incident selection
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(0...currentMessageIndex, id: \.self) { index in
                                MessageBubble(
                                    message: conversation[index].message,
                                    isHD: conversation[index].speaker != "You",
                                    showingSafari: .constant(false)
                                )
                            }
                            
                            if currentMessageIndex >= 2 {
                                // Incident Type Selection
                                VStack(spacing: 12) {
                                    ForEach(IncidentType.allCases, id: \.self) { type in
                                        Button(action: {
                                            handleIncidentSelection(type)
                                        }) {
                                            HStack {
                                                Image(systemName: type.icon)
                                                    .font(.title3)
                                                Text(type.rawValue)
                                                    .font(.headline)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .font(.caption)
                                            }
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(selectedIncident == type ? Color.orange.opacity(0.2) : Color.black.opacity(0.05))
                                            )
                                            .foregroundColor(selectedIncident == type ? .orange : .primary)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                // Show additional messages after selection
                                ForEach(additionalMessages.indices, id: \.self) { index in
                                    MessageBubble(
                                        message: additionalMessages[index].message,
                                        isHD: additionalMessages[index].speaker != "You",
                                        showingSafari: .constant(false)
                                    )
                                    .id(currentMessageIndex + 1 + index)
                                }
                            }
                        }
                        .padding()
                    }
                    .onChange(of: additionalMessages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(lastMessageIndex - 1)
                        }
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
    
    private func handleIncidentSelection(_ type: IncidentType) {
        selectedIncident = type
        
        // Add type-specific conversation
        let newMessages: [(speaker: String, message: String)] = [
            ("You", "I need to report a \(type.rawValue.lowercased())."),
            ("HD", "I understand. I'll help you document this \(type.rawValue.lowercased())."),
            ("HD", "Can you provide more details about what happened?"),
            ("You", "The motorcycle \(getIncidentDescription(for: type))"),
            ("HD", "Thank you for the details. I'm creating an incident report."),
            ("HD", "Would you like me to schedule a service appointment?"),
            ("You", "Yes, please."),
            ("HD", "I'll find the nearest HD service center and check their availability.")
        ]
        
        // Add messages one by one with delay
        for (index, message) in newMessages.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index + 1) * 1.5) {
                additionalMessages.append(message)
            }
        }
    }
    
    private func getIncidentDescription(for type: IncidentType) -> String {
        switch type {
        case .motorFailure:
            return "suddenly stopped running and won't start."
        case .minorFall:
            return "slipped on a wet surface, but there's minimal damage."
        case .softCollision:
            return "was slightly hit while parked, causing minor scratches."
        }
    }
    
    private var lastMessageIndex: Int {
        currentMessageIndex + additionalMessages.count
    }
} 
