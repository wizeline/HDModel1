import SwiftUI
import AppIntents

enum Tab: String, AppEnum {
    case home
    case driving
    case profile
    case more
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Tab"
    static var caseDisplayRepresentations: [Tab : DisplayRepresentation] = [
        .home : .init(stringLiteral: "Home"),
        .driving: .init(stringLiteral: "Driving"),
        .profile : .init(stringLiteral: "Profile"),
        .more : .init(stringLiteral: "More")
    ]
}

enum Route {
    case faq
}

extension Route: View {
    var body: some View {
        switch self {
        case .faq:
            FaqView()
        }
    }
}

extension Route: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }

    static func == (lhs: Route, rhs: Route) -> Bool {
        return true
    }
}
