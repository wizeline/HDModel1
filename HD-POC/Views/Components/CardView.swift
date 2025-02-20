import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            Image("cardImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))

            VStack {
                Spacer()
                HStack {
                    CustomizedButtonView(title: "FAQ", action: myPerformance)
                }
                .padding(.vertical, 6)
                .background(Color.accent)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .frame(height: 300)
        .shadow(color: .text, radius: 2)
    }
}

#Preview {
    CardView()
}
