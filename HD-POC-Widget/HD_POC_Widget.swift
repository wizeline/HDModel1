import WidgetKit
import SwiftUI

struct ProgressWidgetEntry: TimelineEntry {
    let date: Date
    let safetyScore: Int
    let rideStreak: Int
    let lastRideTime: String
}

struct ProgressWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> ProgressWidgetEntry {
        ProgressWidgetEntry(date: Date(), safetyScore: 85, rideStreak: 7, lastRideTime: "2h ago")
    }

    func getSnapshot(in context: Context, completion: @escaping (ProgressWidgetEntry) -> ()) {
        let entry = ProgressWidgetEntry(date: Date(), safetyScore: 85, rideStreak: 7, lastRideTime: "2h ago")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ProgressWidgetEntry>) -> ()) {
        // In a real app, you'd fetch this data from your data store
        let entry = ProgressWidgetEntry(
            date: Date(),
            safetyScore: 85,
            rideStreak: 7,
            lastRideTime: "2h ago"
        )
        
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(15 * 60))) // Update every 15 mins
        completion(timeline)
    }
}

struct ProgressWidgetView: View {
    var entry: ProgressWidgetEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        ZStack {
            // Background with subtle gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black,
                    Color.black.opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 8) {
                // Top badge with safety score and animated ring
                ZStack {
                    // Outer glow
                    Circle()
                        .stroke(Color.orange.opacity(0.2), lineWidth: 6)
                        .frame(width: 66, height: 66)
                        .blur(radius: 2)
                    
                    // Background track
                    Circle()
                        .stroke(Color.orange.opacity(0.3), lineWidth: 4)
                        .frame(width: 60, height: 60)
                    
                    // Animated progress ring
                    Circle()
                        .trim(from: 0, to: CGFloat(entry.safetyScore) / 100)
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                    .orange.opacity(0.7),
                                    .orange
                                ]),
                                center: .center,
                                startAngle: .degrees(-90),
                                endAngle: .degrees(270)
                            ),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                        .frame(width: 60, height: 60)
                        .rotationEffect(.degrees(-90))
                    
                    // Score display
                    VStack(spacing: 0) {
                        Text("\(entry.safetyScore)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.orange)
                        Text("SAFE")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.orange.opacity(0.7))
                    }
                }
                
                // Streak indicator with glowing flame
                HStack(spacing: 4) {
                    ZStack {
                        // Flame glow effect
                        Image(systemName: "flame.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.orange.opacity(0.3))
                            .blur(radius: 2)
                            .offset(y: 1)
                        
                        Image(systemName: "flame.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.orange)
                    }
                    
                    Text("\(entry.rideStreak) DAY STREAK")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                }
                
                // Last ride indicator with shimmer effect
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.orange.opacity(0.7))
                    Text("Last ride: \(entry.lastRideTime)")
                        .font(.system(size: 9))
                        .foregroundColor(.white.opacity(0.7))
                }
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            .white.opacity(0.1),
                            .clear
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .offset(x: -100)
                    .mask(Rectangle().fill(LinearGradient(
                        gradient: Gradient(colors: [.clear, .white, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )))
                )
            }
            .padding(.vertical, 8)
        }
        .containerBackground(.black, for: .widget)
    }
}

struct HarleyWidget: Widget {
    let kind: String = "RiderStats"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ProgressWidgetProvider()) { entry in
            ProgressWidgetView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("Rider Stats")
        .description("Track your safety score and riding streak.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    HarleyWidget()
} timeline: {
    ProgressWidgetEntry(
        date: Date(),
        safetyScore: 85,
        rideStreak: 7,
        lastRideTime: "2h ago"
    )
    ProgressWidgetEntry(
        date: Date(),
        safetyScore: 95,
        rideStreak: 8,
        lastRideTime: "1h ago"
    )
}
