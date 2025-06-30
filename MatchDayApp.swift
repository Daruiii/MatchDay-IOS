import SwiftUI

@main
struct MatchDayApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeViewModel)
        }
    }
} 