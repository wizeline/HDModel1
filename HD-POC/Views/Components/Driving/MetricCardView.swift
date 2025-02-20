import SwiftUI

struct MetricCard: View {
    let metric: SafetyMetric
    let isSelected: Bool
    @State private var isPulsing = false
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.1))
                    .frame(width: 50, height: 50)
                    .scaleEffect(isPulsing ? 1.2 : 1.0)
                    .opacity(isPulsing ? 0.5 : 1.0)
                
                Image(systemName: metric.icon)
                    .font(.title2)
                    .foregroundColor(.orange)
            }
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true)
                ) {
                    isPulsing = true
                }
            }
            
            Text(metric.name)
                .font(.subheadline.bold())
            
            Text("\(Int(metric.score * 100))")
                .font(.title.bold())
                .foregroundColor(.orange)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(isSelected ? 0.05 : 0.02))
        )
        .scaleEffect(isSelected ? 1.05 : 1)
        .animation(.spring(), value: isSelected)
    }
}

#Preview {
    MetricCard(metric: SafetyMetric(name: "Speed", score: 12, icon: "helmet"), isSelected: false)
}
