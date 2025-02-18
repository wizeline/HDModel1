//
//  HomeEntryPointView.swift
//  HD-POC
//
//  Created by Kelderth Krom on 15/02/25.
//

import SwiftUI

struct HomeEntryPointView: View {
    @StateObject var router = NavigationRouter.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                CardView()
                Spacer()
            }
            .navigatable(route: $router.homeRoutes)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("My Inbox")
                    } label: {
                        Image(systemName: "envelope")
                            .tint(.accent)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeEntryPointView()
}


