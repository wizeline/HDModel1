import SwiftUI

struct MyRidesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("MY RIDES (0)")
                .font(.title3)
                .fontWeight(.bold)
            
            Text("You don't have any rides.")
                .font(.subheadline)
        }
    }
}

#Preview {
    MyRidesView()
}
