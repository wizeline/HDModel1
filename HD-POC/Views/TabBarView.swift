import SwiftUI

struct TabBarView: View {
    @StateObject var router = NavigationRouter.shared
    @State private var showingSafetyAssistant = false
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TabView(selection: $router.selectedTab) {
            Group {
                HomeEntryPointView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(Tab.home)

                DrivingEntryPointView()
                    .tabItem {
                        Label("Driving", systemImage: "motorcycle")
                    }
                    .tag(Tab.driving)

                ProfileEntryPointView()
                    .tabItem {
                        Label("Profile", systemImage: "helmet")
                    }
                    .tag(Tab.profile)
            }
        }
        .tint(.orange)
        .toolbarBackground(
            colorScheme == .dark ? Color.black : Color.white,
            for: .tabBar
        )
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .sheet(isPresented: $showingSafetyAssistant) {
            SafetyDialogView()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ShowSafetyAssistant"))) { _ in
            showingSafetyAssistant = true
        }
    }
}

#Preview {
    TabBarView()
}
