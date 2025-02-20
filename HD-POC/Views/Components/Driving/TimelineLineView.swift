import SwiftUI

struct TimelineLine: View {
    let isFirst: Bool
    let isLast: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            if !isFirst {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 1)
                    .frame(height: 20)
            }
            
            if isFirst {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            } else if isLast {
                Image(systemName: "arrow.down.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            } else {
                Circle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
            }
            
            if !isLast {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 1)
                    .frame(maxHeight: .infinity)
                    .frame(height: 100)
            }
        }
    }
}

#Preview {
    TimelineLine(isFirst: true, isLast: false)
}
