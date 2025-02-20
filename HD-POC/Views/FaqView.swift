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
                        // MARK: - Search bar
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

                        // MARK: - FAQ List
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
                                .frame(height: 100)
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

// MARK: - Comprehensive FAQ Data
let faqData: [FaqItem] = FaqItem.mockData
