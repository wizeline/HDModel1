//
//  Enums.swift
//  HD-POC
//
//  Created by Kelderth Krom on 17/02/25.
//

import SwiftUI
import AppIntents

enum Tab: String, AppEnum {
    case home
    case profile
    case more
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Tab"
    static var caseDisplayRepresentations: [Tab : DisplayRepresentation] = [
        .home : .init(stringLiteral: "Home"),
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
