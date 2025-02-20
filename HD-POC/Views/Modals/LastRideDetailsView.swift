import SwiftUI

struct LastRideDetailsView: View {
    @State private var animateCharts = false
    @State private var showStats = false
    @State private var showAnalysis = false
    @State private var showAchievements = false
    @State private var selectedMetric: SafetyMetric?
    @State private var isSpinning = false
    
    private let metrics = [
        SafetyMetric(name: "Braking", score: 0.9, icon: "hand.raised.fill"),
        SafetyMetric(name: "Cornering", score: 0.75, icon: "arrow.turn.right.up"),
        SafetyMetric(name: "Speed", score: 0.85, icon: "gauge.medium"),
        SafetyMetric(name: "Signals", score: 0.95, icon: "arrow.right"),
        SafetyMetric(name: "Position", score: 0.8, icon: "arrow.left.and.right")
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    Color.clear.frame(height: 30)
                    
                    // MARK: - Animated Score Ring
                    ZStack {
                        Circle()
                            .stroke(Color.black.opacity(0.1), lineWidth: 20)
                        
                        Circle()
                            .trim(from: 0, to: animateCharts ? 0.85 : 0)
                            .stroke(
                                AngularGradient(
                                    colors: [.orange, .orange.opacity(0.5)],
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360)
                                ),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: 4) {
                            Text("85")
                                .font(.system(size: 48, weight: .bold))
                            Text("Safety Score")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // MARK: - Animated achievement stars
                        ForEach(0..<3) { index in
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                                .offset(
                                    x: animateCharts ? 60 * cos(Double(index) * 2 * .pi / 3) : 0,
                                    y: animateCharts ? 60 * sin(Double(index) * 2 * .pi / 3) : 0
                                )
                                .scaleEffect(animateCharts ? 1 : 0)
                                .opacity(animateCharts ? 1 : 0)
                        }
                    }
                    .frame(height: 200)
                    .padding(.top)
                    
                    // MARK: - Ride Statistics with animated icons
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(metrics) { metric in
                            MetricCard(metric: metric, isSelected: selectedMetric?.id == metric.id)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedMetric = selectedMetric?.id == metric.id ? nil : metric
                                    }
                                }
                                .scaleEffect(showStats ? 1 : 0.8)
                                .opacity(showStats ? 1 : 0)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Ride Route Map
                    VStack(alignment: .leading, spacing: 8) {
                        Text("RIDE ROUTE")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        RideMapView()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                    
                    if showAchievements {
                        RideAchievementsView()
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            
            CloseButton()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.5)) {
                animateCharts = true
            }
            
            withAnimation(.spring().delay(0.3)) {
                showStats = true
            }
            
            withAnimation(.easeOut.delay(0.6)) {
                showAnalysis = true
            }
            
            withAnimation(.spring().delay(0.9)) {
                showAchievements = true
            }
        }
    }
}

#Preview {
    LastRideDetailsView()
}
