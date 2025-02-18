import SwiftUI

struct ProfileEntryPointView: View {
    @StateObject var router = NavigationRouter.shared
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 60) {
                ProfileView()
                
                MyRidesView()
                
                VStack(alignment: .leading, spacing: 20) {
                    CustomizedButtonView(title: "record a ride", action: noAction)
                    CustomizedButtonView(title: "plan a ride", action: noAction)
                    CustomizedButtonView(title: "my performance", action: myPerformance)
                }
                
                Spacer()
                CustomizedButtonView(title: "logout", action: noAction)
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigatable(route: $router.profileRoutes)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape")
                        .tint(.black)
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "envelope")
                        .tint(.black)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    ProfileEntryPointView()
}
