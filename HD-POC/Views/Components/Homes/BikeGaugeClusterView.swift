import SwiftUI

struct BikeGaugeCluster: View {
    let speed: Int
    let distance: Int
    let safetyScore: Int
    @State private var animateGauges = false
    
    var body: some View {
        HStack(spacing: 20) {
            // MARK: - Speedometer (repurposed for rides)
            SpeedometerGauge(
                value: Double(speed),
                maxValue: 100,
                title: "RIDES",
                units: "total"
            )
            
            // MARK: - Center digital display
            VStack(spacing: 8) {
                Text("\(distance)")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text("MILES")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(width: 100)
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.05))
            )
            
            // MARK: - Safety gauge
            SpeedometerGauge(
                value: Double(safetyScore),
                maxValue: 100,
                title: "SAFETY",
                units: "%",
                color: .orange
            )
        }
        .onAppear {
            // Delay gauge animation (from 5.0 to 1.7)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                withAnimation(.easeOut(duration: 1.5)) {
                    animateGauges = true
                }
            }
        }
    }
}

#Preview {
    BikeGaugeCluster(
        speed: 100,
        distance: 20,
        safetyScore: 15
    )
}
