import SwiftUI

struct CustomizedButtonView: View {
    let title: String
    let action: () -> Void
    @StateObject var router = NavigationRouter.shared
    
    var body: some View {
        Button {
            action()
            if title.uppercased() == "FAQ" {
                router.isFaqVisible = true
            }
        } label: {
            HStack {
                Spacer()
                Text(title.uppercased())
                
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
