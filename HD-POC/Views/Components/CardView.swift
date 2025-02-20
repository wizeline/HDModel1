import SwiftUI

struct CardView: View {
    let imageURL: String
    let title: String
    
    @State private var imageLoaded = false
    @State private var startParallax = false
    
    var animationDelay: Double = 0
    var parallaxDelay: Double = 3
    
    // Example HD image from Unsplash
    static let defaultImageURL = "https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=800"
    
    var body: some View {
        VStack {
            ZStack {
                // Container to constrain image size
                GeometryReader { geo in
                    AsyncImage(url: URL(string: imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaleEffect(1.5)
                                .tint(.accent)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width, height: geo.size.height)
                                .scaleEffect(1.1)
                                .offset(y: startParallax ? -10 : 0)
                                .opacity(imageLoaded ? 1 : 0)
                                .animation(.easeOut(duration: 0.8), value: imageLoaded)
                                .animation(
                                    .easeInOut(duration: 3)
                                    .repeatForever(autoreverses: true),
                                    value: startParallax
                                )
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                                        withAnimation {
                                            imageLoaded = true
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + (animationDelay + parallaxDelay)) {
                                        startParallax = true
                                    }
                                }
                        
                        case .failure(_):
                            Image(systemName: "photo.fill")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .clipped()
                }
                
                // Footer simple sin action
                VStack {
                    Spacer()
                    HStack {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .background(Color.black)
                }
            }
            .contentShape(Rectangle())
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(
                color: .black.opacity(0.2),
                radius: 10,
                x: 0,
                y: 5
            )
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// Preview with example URL
#Preview {
    CardView(
        imageURL: CardView.defaultImageURL,
        title: "FAQ"
    )
}
