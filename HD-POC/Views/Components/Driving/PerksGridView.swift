import SwiftUI

struct PerksGridView: View {
    let tier: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("CURRENT PERKS")
                .font(.caption)
                .foregroundColor(.secondary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                PerkCard(
                    icon: "ticket.fill",
                    title: "HD Events Access",
                    description: "Exclusive access to HD riding events"
                )
                
                PerkCard(
                    icon: "wrench.fill",
                    title: "Priority Service",
                    description: "Skip the line at HD service centers"
                )
                
                PerkCard(
                    icon: "percent",
                    title: "Parts Discount",
                    description: "15% off on genuine HD parts"
                )
                
                PerkCard(
                    icon: "person.2.fill",
                    title: "Community Status",
                    description: "Special badge in HD community"
                )
            }
        }
    }
}

#Preview {
    PerksGridView(tier: "Master")
}
