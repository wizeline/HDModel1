import SwiftUI

final class NavigationRouter: ObservableObject {
    @Published var selectedTab: Tab = .home
    @Published var homeRoutes = NavigationPath()
    @Published var profileRoutes = NavigationPath()
    @Published var isFaqVisible: Bool = false
    
    static var shared = NavigationRouter()
    
    func push(_ tab: Tab? = nil, screen: Route?) {
        if let tab {
            selectedTab = tab
        }

//        guard let screen else { return }
//        
//        switch selectedTab {
//        case .home:
//            homeRoutes.append(screen)
//        case .profile:
//            profileRoutes.append(screen)
//        default:
//            break
//        }
    }
}
