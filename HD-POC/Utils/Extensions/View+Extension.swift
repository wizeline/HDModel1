//
//  View+Extension.swift
//  HD-POC
//
//  Created by Kelderth Krom on 17/02/25.
//

import SwiftUI

extension View {
    func navigatable(route: Binding<NavigationPath>) -> some View {
        modifier(NavigatableView(route: route))
    }
}
