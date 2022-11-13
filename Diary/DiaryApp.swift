import SwiftUI

let authManager = AuthManager()
@main
struct DiaryApp: App {
    
    init() {
        let image = UIImage(systemName: "arrow.left")
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
//        UINavigationBar.appearance().barTintColor = .orange
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .normal)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DiaryFetcher())
                .environmentObject(observed())
                .environmentObject(authManager)
        }
    }
}
