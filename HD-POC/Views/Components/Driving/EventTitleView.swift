import SwiftUI

struct EventTitle: View {
    let type: EventType
    
    var body: some View {
        Text(title)
            .font(.headline)
    }
    
    private var title: String {
        switch type {
        case .positiveScore(_, let title, _): return title
        case .negativeScore(_, let title, _): return title
        case .achievement(_, let title, _): return title
        case .systemEvent(let title, _): return title
        }
    }
}

#Preview {
    EventTitle(type: .positiveScore(1, "Hello", "World"))
}
