import SwiftUI

struct MoreItemView: View {
    let item: MoreContentItem
    @State var isFaqModalVisible = false
    @StateObject var router = NavigationRouter.shared
    
    var body: some View {
        VStack {
            Button {
                item.event?()
                if item.title == "my performance" {
                    router.isFaqVisible = true
                }
            } label: {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: item.icon)
                    Text(item.title.uppercased())
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.accent)
                .tint(.accent)
                .font(.title3)
            }
            .buttonStyle(NoHighlightButtonStyle())
            .sheet(isPresented: $router.isFaqVisible) {
                FaqView()
            }
            Rectangle()
                .fill(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8))
                .frame(height: 2)
        }
        .frame(height: 50)
    }
}

#Preview {
    MoreItemView(
        item: MoreContentItem(
            icon: "helmet.fill",
            title: "my performance"
        )
    )
}
