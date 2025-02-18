import Foundation

struct MoreContentItem: Identifiable {
    let id: UUID = UUID()
    let icon: String
    let title: String
    var event: (() -> Void)? = nil
}

// MARK: - mock data
extension MoreContentItem {
    static func mockData() -> [MoreContentItem] {
        return [
            MoreContentItem(icon: "motorcycle.fill", title: "motorcycles"),
            MoreContentItem(icon: "calendar.badge.clock", title: "schedule a test ride"),
            MoreContentItem(icon: "iphone.dock.motorized.viewfinder", title: "find a dealer"),
            MoreContentItem(icon: "person.text.rectangle", title: "learn to ride"),
            MoreContentItem(icon: "calendar", title: "events"),
            MoreContentItem(icon: "motorcycle", title: "rent a bike"),
            MoreContentItem(icon: "building.columns", title: "museum"),
            MoreContentItem(icon: "cart.fill", title: "apparel & gifts"),
            MoreContentItem(icon: "helmet.fill", title: "my performance", event: myPerformance)
        ]
    }
}
