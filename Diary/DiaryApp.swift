import SwiftUI

@main
struct DiaryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(DiaryFetcher())
                .environmentObject(observed())
        }
    }
}
