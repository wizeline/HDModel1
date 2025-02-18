import SwiftUI

struct NavigatableView: ViewModifier {
    @Binding var route: NavigationPath

    func body(content: Content) -> some View {
        NavigationStack(path: $route) {
            content
                .navigationDestination(for: Route.self) { value in
                    value
                }
        }
    }
}
