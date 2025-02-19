//
//  HD_POC_WidgetLiveActivity.swift
//  HD-POC-Widget
//
//  Created by Fabian Romero Sotelo on 18/02/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

// The attributes that define the Live Activity
struct HD_POC_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var rideStatus: String
        var safetyScore: Int
        var currentSpeed: Double
        var distanceTraveled: Double
        var timeElapsed: TimeInterval
        var nextTurn: String?
    }
    
    var rideName: String
    var startTime: Date
}

struct HD_POC_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HD_POC_WidgetAttributes.self) { context in
            // Dynamic Island and Lock Screen UI
            HStack {
                rideStatusView(context: context)
                Divider()
                safetyScoreView(context: context)
                if let nextTurn = context.state.nextTurn {
                    Divider()
                    navigationView(nextTurn: nextTurn)
                }
            }
            .activityBackgroundTint(.black.opacity(0.8))
            .activitySystemActionForegroundColor(.orange)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: "motorcycle.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .foregroundStyle(.orange)
                                .font(.title2)
                                .rotationEffect(.degrees(context.state.currentSpeed > 0 ? 5 : 0))
                                .animation(.easeInOut(duration: 0.5).repeatForever(), value: context.state.currentSpeed > 0)
                            
                            Text(context.state.rideStatus)
                                .font(.headline)
                                .foregroundStyle(.orange)
                        }
                        Text(context.attributes.rideName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Text("\(context.state.safetyScore)%")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundStyle(.orange)
                            .contentTransition(.numericText())
                        
                        Text("Safety")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    HStack(spacing: 25) {
                        // Speed with animated gauge
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(.gray.opacity(0.2), lineWidth: 3)
                                Circle()
                                    .trim(from: 0, to: min(CGFloat(context.state.currentSpeed) / 100, 1))
                                    .stroke(.orange, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    .animation(.smooth, value: context.state.currentSpeed)
                                
                                Text(String(format: "%.0f", context.state.currentSpeed))
                                    .font(.system(.body, design: .rounded, weight: .bold))
                                    .contentTransition(.numericText())
                            }
                            .frame(width: 40, height: 40)
                            
                            Text("mph")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        
                        // Distance
                        VStack {
                            Text(String(format: "%.1f", context.state.distanceTraveled))
                                .font(.system(.body, design: .rounded, weight: .bold))
                                .contentTransition(.numericText())
                            Text("mi")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        
                        // Time
                        VStack {
                            Text(timeString(from: context.state.timeElapsed))
                                .font(.system(.body, design: .rounded, weight: .bold))
                                .contentTransition(.numericText())
                            Text("time")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    if let nextTurn = context.state.nextTurn {
                        HStack {
                            Image(systemName: "arrow.turn.up.right")
                                .symbolRenderingMode(.multicolor)
                                .foregroundStyle(.orange)
                                .font(.body)
                            Text(nextTurn)
                                .font(.callout)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.push(from: .trailing))
                    }
                }
            } compactLeading: {
                Image(systemName: "motorcycle.circle.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.orange)
                    .rotationEffect(.degrees(context.state.currentSpeed > 0 ? 5 : 0))
                    .animation(.easeInOut(duration: 0.5).repeatForever(), value: context.state.currentSpeed > 0)
            } compactTrailing: {
                Text("\(context.state.safetyScore)%")
                    .contentTransition(.numericText())
                    .foregroundStyle(.orange)
            } minimal: {
                Image(systemName: "motorcycle.circle.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.orange)
            }
        }
    }
    
    // Helper views
    @ViewBuilder
    private func rideStatusView(context: ActivityViewContext<HD_POC_WidgetAttributes>) -> some View {
        VStack(alignment: .leading) {
            Label {
                Text(context.state.rideStatus)
                    .font(.headline)
            } icon: {
                Image(systemName: "motorcycle.circle.fill")
                    .foregroundStyle(.orange)
            }
            Text(context.attributes.rideName)
                .font(.caption)
        }
    }
    
    @ViewBuilder
    private func safetyScoreView(context: ActivityViewContext<HD_POC_WidgetAttributes>) -> some View {
        VStack {
            Text("\(context.state.safetyScore)%")
                .font(.title2.bold())
                .foregroundStyle(.orange)
            Text("Safety")
                .font(.caption)
        }
    }
    
    @ViewBuilder
    private func statsView(context: ActivityViewContext<HD_POC_WidgetAttributes>) -> some View {
        HStack(spacing: 20) {
            VStack {
                Text(String(format: "%.1f", context.state.currentSpeed))
                    .font(.title3.bold())
                Text("mph")
                    .font(.caption)
            }
            
            VStack {
                Text(String(format: "%.1f", context.state.distanceTraveled))
                    .font(.title3.bold())
                Text("miles")
                    .font(.caption)
            }
            
            VStack {
                Text(timeString(from: context.state.timeElapsed))
                    .font(.title3.bold())
                Text("time")
                    .font(.caption)
            }
        }
    }
    
    @ViewBuilder
    private func navigationView(nextTurn: String) -> some View {
        Label {
            Text(nextTurn)
                .font(.callout)
        } icon: {
            Image(systemName: "arrow.turn.up.right.circle.fill")
                .foregroundStyle(.orange)
        }
    }
    
    private func timeString(from interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
    }
}

extension HD_POC_WidgetAttributes {
    fileprivate static var preview: HD_POC_WidgetAttributes {
        HD_POC_WidgetAttributes(rideName: "World", startTime: Date())
    }
}

extension HD_POC_WidgetAttributes.ContentState {
    fileprivate static var riding: HD_POC_WidgetAttributes.ContentState {
        HD_POC_WidgetAttributes.ContentState(
            rideStatus: "Riding",
            safetyScore: 95,
            currentSpeed: 35.0,
            distanceTraveled: 10.0,
            timeElapsed: 300.0,
            nextTurn: "Turn left on Main St"
        )
    }
     
    fileprivate static var stopped: HD_POC_WidgetAttributes.ContentState {
        HD_POC_WidgetAttributes.ContentState(
            rideStatus: "Stopped",
            safetyScore: 80,
            currentSpeed: 0.0,
            distanceTraveled: 15.5,
            timeElapsed: 1800.0,
            nextTurn: nil
        )
    }
}

#Preview("Dynamic Island Compact", as: .dynamicIsland(.compact), using: HD_POC_WidgetAttributes.preview) {
   HD_POC_WidgetLiveActivity()
} contentStates: {
    HD_POC_WidgetAttributes.ContentState.riding
    HD_POC_WidgetAttributes.ContentState.stopped
}

#Preview("Dynamic Island Expanded", as: .dynamicIsland(.expanded), using: HD_POC_WidgetAttributes.preview) {
   HD_POC_WidgetLiveActivity()
} contentStates: {
    HD_POC_WidgetAttributes.ContentState.riding
}

#Preview("Dynamic Island Minimal", as: .dynamicIsland(.minimal), using: HD_POC_WidgetAttributes.preview) {
   HD_POC_WidgetLiveActivity()
} contentStates: {
    HD_POC_WidgetAttributes.ContentState.riding
}
