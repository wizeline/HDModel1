import SwiftUI

struct FaqView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var expandedQuestions: Set<String> = []
    @State private var searchTokens: Set<String> = []
    @State private var isSearching = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .topTrailing) {
                    VStack(spacing: 0) {
                        // Search bar with smoother animation
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.orange)
                                .scaleEffect(isSearching ? 1.1 : 1.0)
                                .opacity(isSearching ? 0.7 : 1.0)
                            TextField("Search FAQs", text: $searchText)
                                .onChange(of: searchText) { _ in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isSearching = true
                                    }
                                    updateSearchTokens()
                                    
                                    // Reset the animation after a short delay
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            isSearching = false
                                        }
                                    }
                                }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black.opacity(0.05))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .padding()
                        .padding(.top, 32)

                        // FAQ List
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(filteredFaqs) { faq in
                                    FaqCardView(
                                        faq: faq,
                                        isExpanded: expandedQuestions.contains(faq.id),
                                        onTap: {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                                if expandedQuestions.contains(faq.id) {
                                                    expandedQuestions.remove(faq.id)
                                                } else {
                                                    expandedQuestions.insert(faq.id)
                                                }
                                            }
                                        }
                                    )
                                    .transition(.asymmetric(
                                        insertion: .scale.combined(with: .opacity),
                                        removal: .scale.combined(with: .opacity)
                                    ))
                                }
                                
                                // Add bottom spacing
                                Color.clear.frame(height: 100)
                            }
                            .padding(.horizontal)
                        }
                        .mask(
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.white)
                                LinearGradient(
                                    gradient: Gradient(colors: [.white, .clear]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 100)  // Increased from 50 to 100
                            }
                        )
                    }

                    CloseButton()
                }
            }
            .navigationTitle("FAQ")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func updateSearchTokens() {
        searchTokens = Set(searchText.lowercased()
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
        )
    }
    
    private var filteredFaqs: [FaqItem] {
        if searchTokens.isEmpty {
            return faqData
        }
        return faqData.filter { faq in
            let questionTokens = Set(faq.question.lowercased()
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty })
            let answerTokens = Set(faq.answer.lowercased()
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty })
            let keywordTokens = Set(faq.keywords)
            
            return !searchTokens.isDisjoint(with: questionTokens) ||
                   !searchTokens.isDisjoint(with: answerTokens) ||
                   !searchTokens.isDisjoint(with: keywordTokens)
        }
    }
}

#Preview {
    FaqView()
}

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

struct FaqItem: Identifiable {
    let id = UUID().uuidString
    let question: String
    let answer: String
    let keywords: [String]
}

// Comprehensive FAQ Data
let faqData: [FaqItem] = [
    FaqItem(
        question: "How often should I check my motorcycle's tire pressure?",
        answer: "Check tire pressure at least weekly when the tires are cold. For most Harley-Davidson motorcycles, the recommended pressure is typically between 30-40 PSI, but always refer to your specific model's manual. Proper tire pressure is crucial for handling, safety, and tire longevity.",
        keywords: ["tire", "pressure", "maintenance", "safety", "psi", "check"]
    ),
    FaqItem(
        question: "What's the break-in procedure for a new Harley-Davidson?",
        answer: "During the first 500 miles: Avoid full throttle starts, don't exceed 3000 RPM, vary engine speed, avoid constant speed for long periods, and use extra caution. This helps ensure proper seating of piston rings and other components.",
        keywords: ["break-in", "new", "motorcycle", "engine", "maintenance", "first", "miles"]
    ),
    FaqItem(
        question: "How does the HD-Connect safety system work?",
        answer: "HD-Connect uses advanced sensors and AI to monitor your riding patterns, road conditions, and bike performance in real-time. It provides proactive alerts for potential hazards, suggests safer routes based on current conditions, and can automatically notify emergency contacts in case of an incident.",
        keywords: ["safety", "connect", "monitoring", "alerts", "emergency", "system"]
    ),
    FaqItem(
        question: "What should I do if my bike's safety system detects an issue?",
        answer: "If you receive a safety alert, find a safe place to stop. The app will provide detailed information about the detected issue and recommend appropriate action. For serious issues, it can connect you directly with HD support or emergency services.",
        keywords: ["safety", "alert", "emergency", "support", "issue", "problem"]
    ),
    FaqItem(
        question: "How do I maximize my safety score in the HD app?",
        answer: "Your safety score improves with consistent, smooth riding: maintain steady speeds, brake gradually, take turns smoothly, and follow traffic rules. The app analyzes your riding patterns and provides personalized tips for improvement.",
        keywords: ["safety", "score", "riding", "improvement", "tips", "app"]
    ),
    FaqItem(
        question: "What's included in the HD emergency assistance package?",
        answer: "The package includes 24/7 roadside assistance, emergency towing to the nearest HD dealer, fuel delivery, battery jump-start, and flat tire assistance. It also provides emergency medical coordination and travel interruption benefits.",
        keywords: ["emergency", "assistance", "roadside", "towing", "help"]
    ),
    FaqItem(
        question: "How does the weather alert system work?",
        answer: "The system monitors real-time weather conditions along your route. It alerts you to severe weather, suggests alternative routes, and provides safe stopping points. Alerts include precipitation, temperature changes, and severe weather warnings.",
        keywords: ["weather", "alerts", "conditions", "safety", "route"]
    ),
    FaqItem(
        question: "What's the recommended maintenance schedule for my HD?",
        answer: "Basic checks (oil, tires, brakes) should be done monthly. Major service intervals vary by model but typically occur at 1,000, 5,000, and 10,000 miles. The app tracks your mileage and sends maintenance reminders based on your specific model.",
        keywords: ["maintenance", "service", "schedule", "checks", "reminders"]
    ),
    FaqItem(
        question: "How does the group ride feature work?",
        answer: "The group ride feature lets you create or join ride groups, share real-time locations, and communicate through the intercom system. It includes safety features like group speed monitoring and automatic regrouping suggestions.",
        keywords: ["group", "ride", "social", "communication", "tracking"]
    ),
    FaqItem(
        question: "What should I do if my bike detects a mechanical issue?",
        answer: "When the system detects an issue, it will provide a detailed diagnostic report and severity level. For minor issues, you'll receive maintenance recommendations. For serious problems, it will guide you to the nearest HD service center and can automatically schedule an appointment.",
        keywords: ["mechanical", "issue", "diagnostic", "service", "maintenance", "problem"]
    )
]

struct CustomGroupBoxStyle : GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.content
            configuration.label
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        }
    }
}
