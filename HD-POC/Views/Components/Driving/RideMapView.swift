import SwiftUI
import MapKit

struct RideMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 43.0411,
            longitude: -87.9677
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )
    
    @State private var isPulsing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("RIDE LOCATION")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ZStack {
                Map(coordinateRegion: $region)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // MARK: - Custom motorcycle marker
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .scaleEffect(isPulsing ? 1.3 : 1.0)
                        .opacity(isPulsing ? 0.5 : 1.0)
                    
                    Image(systemName: "motorcycle.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.orange)
                }
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true)
                    ) {
                        isPulsing = true
                    }
                }
            }
            .frame(height: 200)
            
            // MARK: - Location details
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.orange)
                    .font(.caption)
                Text("Harley-Davidson HQ • Milwaukee, WI")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RideMapView()
}
