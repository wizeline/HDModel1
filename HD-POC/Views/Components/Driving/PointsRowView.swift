import SwiftUI

struct PointsRow: View {
    let title: String
    let points: String
    let description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.bold())
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(points)
                .font(.headline)
                .foregroundColor(.orange)
        }
        .padding()
        .background(Color.black.opacity(0.05))
    }
}

#Preview {
    PointsRow(title: "Master", points: "300", description: "Top Score on Master Mode")
}
