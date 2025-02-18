//
//  TabBarView.swift
//  HD-POC
//
//  Created by Kelderth Krom on 15/02/25.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var router = NavigationRouter.shared
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            Group {
                HomeEntryPointView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(Tab.home)
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
    }
}

#Preview {
    TabBarView()
}
