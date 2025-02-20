import SwiftUI

struct HomeEntryPointView: View {
    @State private var showingSafetyDialog = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        // MARK: - Welcome header
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Welcome back")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                                Text("John Smith")
                                    .font(.title.bold())
                            }
                            Spacer()
                            
                            Image(systemName: "shield.checkered.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.orange.gradient)
                        }
                        .padding(.horizontal)
                        
                        BikeGaugeCluster(
                            speed: 42,
                            distance: 1250,
                            safetyScore: 95
                        )
                        .frame(height: 160)
                        .padding(.horizontal)
                        
                        Button {
                            NavigationUtil.push(FaqView())
                        } label: {
                            CardView(
                                imageURL: CardView.defaultImageURL,
                                title: "FAQ"
                            )
                        }
                        
                        CardView(
                            imageURL: "https://images.unsplash.com/photo-1609630875171-b1321377ee65",
                            title: "DISCOVER RIDES",
                            animationDelay: 0.3,
                            parallaxDelay: 1.0
                        )
                    }
                    .padding(.vertical)
                }
                
                // MARK: - Safety button
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
