import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Group {
                Image(systemName: "helmet")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)
                    .frame(width: 40, height: 40)
                    .padding(.horizontal, 18)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            .frame(height: 80)
            .background(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.5))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            
            VStack(alignment: .leading) {
                Text("John Doe")
                Text("johnDoe@email.com")
            }
            .foregroundStyle(.accent)
            .tint(.accent)
            
            Spacer()
            Image(systemName: "pencil")
                .fontWeight(.bold)
                .font(.title3)
        }
        .frame(height: 80)
        .background(.clear)
        .padding(.top, 20)
    }
}

#Preview {
    ProfileView()
}
