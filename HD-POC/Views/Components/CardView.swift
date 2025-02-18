import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            Image("cardImage")
                .resizable()
            
            VStack {
                Spacer()
                HStack {
                    CustomizedButtonView(title: "my performance", action: myPerformance)
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
