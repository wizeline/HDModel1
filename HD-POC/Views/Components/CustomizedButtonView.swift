//
//  CustomizedButtonView.swift
//  HD-POC
//
//  Created by Kelderth Krom on 15/02/25.
//

import SwiftUI

struct CustomizedButtonView: View {
    let title: String
    let action: () -> Void
    @StateObject var router = NavigationRouter.shared
    @State var isFaqModalVisible: Bool = false
    
    var body: some View {
        Button {
            action()
            if title == "my performance" {
                isFaqModalVisible.toggle()
            }
        } label: {
            HStack {
                Spacer()
                Text(title.capitalized)
                
                Image(systemName: "arrow.right")
                Spacer()
            }
            .font(.headline)
            .fontWeight(.bold)
            .frame(height: 40)
            .foregroundStyle(.text)
            .background(Color.accent)
        }
        .buttonStyle(.borderedProminent)
        .tint(.accent)
        .sheet(isPresented: $router.isFaqVisible) {
            FaqView()
        }
    }
}

#Preview("Black Text with Right Arrow Icon Button") {
    CustomizedButtonView(title: "Title", action: noAction)
}
