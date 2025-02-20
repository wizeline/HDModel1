import SwiftUI

struct UserHeaderView: View {
    let username: String
    let score: Int
    let rank: String
    let phrase: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: - Greeting and Score
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello, \(username)!")
                        .font(.title2.bold())
                    
                    HStack(spacing: 4) {
                        Text(rank)
                            .font(.subheadline.bold())
                        Text("•")
                            .foregroundColor(.secondary)
                        Text("\(score) pts")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                }
                Spacer()
            }
            
            // MARK: - Encouraging Phrase
            Text(phrase)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
                .padding(.top, 8)
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    UserHeaderView(username: "John", score: 300, rank: "Beginner", phrase: "Keep practicing!")
}
