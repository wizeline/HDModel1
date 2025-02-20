import WidgetKit
import SwiftUI

@main
struct HD_POC_WidgetBundle: WidgetBundle {
    var body: some Widget {
        HarleyWidget()
        HD_POC_WidgetControl()
        HD_POC_WidgetLiveActivity()
    }
}
