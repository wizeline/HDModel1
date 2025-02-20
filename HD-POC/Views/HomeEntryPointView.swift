import SwiftUI

struct HomeEntryPointView: View {
    @StateObject var router = NavigationRouter.shared
    @State private var showingSafetyDialog = false
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingSafetyButton(showingSafetyDialog: $showingSafetyDialog)
                            .padding(.trailing, 16)
                            .padding(.bottom, 16)
                    }
                }
            }
            .sheet(isPresented: $showingSafetyDialog) {
                SafetyDialogView()
            }
        }
    }
}

#Preview {
    HomeEntryPointView()
}


