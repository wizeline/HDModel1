//
//  HD_POC_Widget.swift
//  HD-POC-Widget
//
//  Created by Fabian Romero Sotelo on 18/02/25.
//

import WidgetKit
import SwiftUI

struct ProgressWidgetEntry: TimelineEntry {
    let date: Date
    let progress: Double
}

struct ProgressWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> ProgressWidgetEntry {
        ProgressWidgetEntry(date: Date(), progress: 50)
    }

    func getSnapshot(in context: Context, completion: @escaping (ProgressWidgetEntry) -> ()) {
        let entry = ProgressWidgetEntry(date: Date(), progress: 50)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ProgressWidgetEntry>) -> ()) {
        let entries: [ProgressWidgetEntry] = [
            ProgressWidgetEntry(date: Date(), progress: 30),
            ProgressWidgetEntry(date: Date().addingTimeInterval(5), progress: 50),
            ProgressWidgetEntry(date: Date().addingTimeInterval(10), progress: 70),
            ProgressWidgetEntry(date: Date().addingTimeInterval(15), progress: 100)
        ]
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct ProgressWidgetView: View {
    var entry: ProgressWidgetEntry
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .foregroundColor(Color.gray.opacity(0.3))
                
                Circle()
                    .trim(from: 0, to: CGFloat(entry.progress / 100))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .foregroundColor(entry.progress == 100 ? Color.green : Color.blue)
                    .rotationEffect(.degrees(-90))
                
                Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                    .font(.system(size: 40))
                    .foregroundColor(entry.progress == 100 ? Color.green : Color.blue)

            }
            .frame(width: 80, height: 80)
            .padding()
            
            VStack {
                Text("\(Int(entry.progress))/100")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(entry.progress == 100 ? Color.green : Color.blue)
                
                Text("Acceleration")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(entry.progress == 100 ? Color.green : Color.blue)
            }
        }
        .widgetURL(URL(string: "myapp://progress"))
    }
}

struct HarleyWidget: Widget {
    let kind: String = "ProgressWidget"

    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: ProgressWidgetProvider()) { entry in
            ProgressWidgetView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("Progreso de Moto")
        .description("Muestra el progreso de la conducción en tiempo real.")
        .supportedFamilies([.systemSmall])
    }
}

//#Preview(as: .systemSmall) {
//    HD_POC_Widget()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}
