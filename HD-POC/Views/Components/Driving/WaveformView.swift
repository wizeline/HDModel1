import SwiftUI

struct WaveformView: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<10) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.orange)
                    .frame(width: 3)
                    .frame(height: isAnimating ? heights[index] : 10)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }
    
    private let heights: [CGFloat] = [20, 40, 30, 50, 25, 45, 35, 40, 30, 20]
}

#Preview {
    WaveformView(isAnimating: .constant(false))
}
