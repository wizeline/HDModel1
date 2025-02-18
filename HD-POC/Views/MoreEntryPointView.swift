import SwiftUI

struct MoreEntryPointView: View {
    let items: [MoreContentItem] = MoreContentItem.mockData()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items, id: \.id) { item in
                    MoreItemView(item: item)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.inset)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "envelope")
                        .tint(.black)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    MoreEntryPointView()
}
