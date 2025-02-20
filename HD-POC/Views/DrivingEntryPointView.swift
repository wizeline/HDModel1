import SwiftUI

public struct DrivingEntryPointView: View {
    @State private var selectedModal: ModalType?
    @State private var timelineScrollOffset: CGFloat = 0
    @State private var showingSafetyDialog = false
    @State private var showingSoftCollisionDialog = false
    @State private var showingRoadIncidentDialog = false
    
    private let username = "John"
    private let score = 2850
    private let rank = "Road Master"
    private let encouragingPhrases = Constants.encouragingPhrases
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: - User Header
                UserHeaderView(
                    username: username,
                    score: score,
                    rank: rank,
                    phrase: encouragingPhrases.randomElement() ?? ""
                )
                .padding(.horizontal)
                .padding(.top, 16)
                
                // MARK: - Main Timeline View
                TimelineScrollView()
            }
            
            // MARK: - Safety Button (top right)
            VStack {
                HStack {
                    Spacer()
                    // MARK: - Soft Collision Button
                    Button(action: { showingSoftCollisionDialog = true }) {
                        Image(systemName: "motorcycle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color.yellow)
                                    .shadow(radius: 2)
                            )
                    }
                    .padding(.trailing, 8)
                    
                    // MARK: - Road Incident Button
                    Button(action: { showingRoadIncidentDialog = true }) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color.red)
                                    .shadow(radius: 2)
                            )
                    }
                    .padding(.trailing, 16)
                }
                .padding(.top, 8)
                Spacer()
                
                NavigationBar(selectedModal: $selectedModal)
            }
        }
        .sheet(item: $selectedModal) { modalType in
            switch modalType {
            case .lastRideDetails:
                LastRideDetailsView()
            case .rideRewards:
                RideRewardsView()
            }
        }
        .sheet(isPresented: $showingSoftCollisionDialog) {
            IncidentReportView()
        }
        .sheet(isPresented: $showingRoadIncidentDialog) {
            EmergencyIncidentView()
        }
    }
}

#Preview {
    DrivingEntryPointView()
}
