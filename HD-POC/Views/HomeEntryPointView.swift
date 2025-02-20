import SwiftUI

struct HomeEntryPointView: View {
    @State private var showingSafetyDialog = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        // Welcome header
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Welcome back")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                                Text("John Smith")
                                    .font(.title.bold())
                            }
                            Spacer()
                            
                            Image(systemName: "shield.checkered.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.orange.gradient)
                        }
                        .padding(.horizontal)
                        
                        // Gauge cluster - its internal animations will still work
                        BikeGaugeCluster(
                            speed: 42,
                            distance: 1250,
                            safetyScore: 95
                        )
                        .frame(height: 160)
                        .padding(.horizontal)
                        
                        // Cards - their internal animations will still work
                        Button {
                            NavigationUtil.push(FaqView())
                        } label: {
                            CardView(
                                imageURL: CardView.defaultImageURL,
                                title: "FAQ"
                            )
                        }
                        
                        CardView(
                            imageURL: "https://images.unsplash.com/photo-1609630875171-b1321377ee65",
                            title: "DISCOVER RIDES",
                            animationDelay: 0.3,
                            parallaxDelay: 1.0
                        )
                    }
                    .padding(.vertical)
                }
                
                // Safety button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingSafetyButton(showingSafetyDialog: $showingSafetyDialog)
                            .padding(.trailing, 16)
                            .padding(.bottom, 16)
                    }
                }
            }
            .sheet(isPresented: $showingSafetyDialog) {
                SafetyDialogView()
            }
        }
    }
}

// Helper for programmatic navigation
enum NavigationUtil {
    static func push(_ view: some View) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let rootViewController = window?.rootViewController
        let hostingController = UIHostingController(rootView: view)
        rootViewController?.present(hostingController, animated: true)
    }
}

// Enhanced stat card
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let delay: Double
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.orange.gradient)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: false)
                    .delay(delay),
                    value: isAnimating
                )
            
            Text(value)
                .font(.title2.bold())
                .scaleEffect(isAnimating ? 1.1 : 1)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)
                    .delay(delay),
                    value: isAnimating
                )
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 120)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.05))
        )
        .onAppear {
            isAnimating = true
        }
    }
}

// New motorcycle gauge cluster
struct BikeGaugeCluster: View {
    let speed: Int
    let distance: Int
    let safetyScore: Int
    @State private var animateGauges = false
    
    var body: some View {
        HStack(spacing: 20) {
            // Speedometer (repurposed for rides)
            SpeedometerGauge(
                value: Double(speed),
                maxValue: 100,
                title: "RIDES",
                units: "total"
            )
            
            // Center digital display
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
            
            // Safety gauge
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
                // Gauge background
                Circle()
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 8)
                
                // Value indicator
                Circle()
                    .trim(from: 0, to: animatedValue / maxValue)
                    .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                // Digital value
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
    HomeEntryPointView()
}


