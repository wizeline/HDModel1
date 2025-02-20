import SwiftUI

struct TimelineEvent: View {
    let index: Int
    let isLast: Bool
    @State private var isVisible = false
    
    // MARK: - Mock data with all possible events
    var eventType: EventType {
        EventType.mockEventTypes[index % 40] // Using 40 to show all events in rotation
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            TimelineLine(isFirst: index == 0, isLast: isLast)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    EventIcon(type: eventType)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        EventTitle(type: eventType)
                        Text("February 20, 2025 • 3:45 PM")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    EventScore(type: eventType)
                }
                
                EventDescription(type: eventType)
                
                if !isLast {
                    Divider()
                        .padding(.top, 8)
                }
            }
            .padding(.vertical, 16)
        }
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.3).delay(Double(index) * 0.1)) {
                isVisible = true
            }
        }
    }
}

#Preview {
    TimelineEvent(index: 0, isLast: false)
}
