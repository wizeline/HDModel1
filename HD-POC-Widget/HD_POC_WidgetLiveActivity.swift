//
//  HD_POC_WidgetLiveActivity.swift
//  HD-POC-Widget
//
//  Created by Fabian Romero Sotelo on 18/02/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct HD_POC_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct HD_POC_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HD_POC_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension HD_POC_WidgetAttributes {
    fileprivate static var preview: HD_POC_WidgetAttributes {
        HD_POC_WidgetAttributes(name: "World")
    }
}

extension HD_POC_WidgetAttributes.ContentState {
    fileprivate static var smiley: HD_POC_WidgetAttributes.ContentState {
        HD_POC_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: HD_POC_WidgetAttributes.ContentState {
         HD_POC_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: HD_POC_WidgetAttributes.preview) {
   HD_POC_WidgetLiveActivity()
} contentStates: {
    HD_POC_WidgetAttributes.ContentState.smiley
    HD_POC_WidgetAttributes.ContentState.starEyes
}
