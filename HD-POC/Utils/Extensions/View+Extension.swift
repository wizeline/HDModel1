import SwiftUI

extension View {
    func navigatable(route: Binding<NavigationPath>) -> some View {
        modifier(NavigatableView(route: route))
    }
}
