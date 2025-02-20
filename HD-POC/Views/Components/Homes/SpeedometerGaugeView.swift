import SwiftUI

struct SpeedometerGauge: View {
    let value: Double
    let maxValue: Double
    let title: String
    let units: String
    var color: Color = .orange
    
    @State private var animatedValue = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                // MARK: - Gauge background
                Circle()
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 8)
                
                // MARK: - Value indicator
                Circle()
                    .trim(from: 0, to: animatedValue / maxValue)
                    .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                // MARK: - Digital value
                VStack(spacing: 4) {
                    Text("\(Int(animatedValue))")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .monospacedDigit()
                    Text(units)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .onAppear {
            // Start after BikeGaugeCluster (from 6.0 to 2.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                withAnimation(.easeOut(duration: 1.5)) {
                    animatedValue = value
                }
            }
        }
    }
}

#Preview {
    SpeedometerGauge(value: 20.0, maxValue: 50.0, title: "Speed", units: "MPH")
}
