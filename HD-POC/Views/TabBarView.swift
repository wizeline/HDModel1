import SwiftUI

struct TabBarView: View {
    @StateObject var router = NavigationRouter.shared
    @State private var showingSafetyAssistant = false
    
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

                MoreEntryPointView()
                    .tabItem {
                        Label("More", systemImage: "ellipsis")
                    }
                    .tag(Tab.more)
            }
            .toolbarBackgroundVisibility(.visible, for: .tabBar)
            .toolbarBackground(.accent, for: .tabBar)
        }
        .tint(.orange)
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
