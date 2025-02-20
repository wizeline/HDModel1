import SwiftUI
import UIKit
import SwiftUICore

/// Helper for programmatic navigation
enum NavigationUtil {
    static func push(_ view: some View) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let rootViewController = window?.rootViewController
        let hostingController = UIHostingController(rootView: view)
        rootViewController?.present(hostingController, animated: true)
    }
}
