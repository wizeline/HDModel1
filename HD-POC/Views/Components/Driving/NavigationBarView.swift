import SwiftUI

struct NavigationBar: View {
    @Binding var selectedModal: ModalType?
    
    var body: some View {
        HStack(spacing: 20) {
            NavigationButton(
                icon: "clock.fill",
                title: "Last Ride",
                color: .black
            ) {
                selectedModal = .lastRideDetails
            }
            
            NavigationButton(
                icon: "star.fill",
                title: "Rewards",
                color: .orange
            ) {
                selectedModal = .rideRewards
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 5)
        )
        .padding()
    }
}

#Preview {
    NavigationBar(selectedModal: .constant(.lastRideDetails))
}
