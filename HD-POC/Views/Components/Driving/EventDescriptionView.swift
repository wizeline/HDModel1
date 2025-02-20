import SwiftUI

struct EventDescription: View {
    let type: EventType
    
    var body: some View {
        Text(description)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    
    private var description: String {
        switch type {
        case .positiveScore(_, _, let desc): return desc
        case .negativeScore(_, _, let desc): return desc
        case .achievement(_, _, let desc): return desc
        case .systemEvent(_, let desc): return desc
        }
    }
}

#Preview {
    EventDescription(type: .positiveScore(1, "Hello", "World"))
}
