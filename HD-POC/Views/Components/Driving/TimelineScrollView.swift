import SwiftUI

struct TimelineScrollView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<40) { index in
                    TimelineEvent(index: index, isLast: index == 39)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                Color.clear
                    .frame(height: 150)
            }
            .padding(.vertical)
        }
        .background(Color(.systemBackground))
        .mask(
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.white)
                LinearGradient(
                    gradient: Gradient(colors: [.white, .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
            }
        )
    }
}

#Preview {
    TimelineScrollView()
}
