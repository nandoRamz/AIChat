//
//  AppView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct AppView: View {
    @Environment(AuthManager.self) private var authManager
    
    @State var appState = AppState()
    @State private var isPerformingTask: Bool = true
    
    var body: some View {
        AppViewBuilder(
            isSignedIn: authManager.auth != nil,
            isPerformingTask: isPerformingTask,
            tabBarView: { TabBarView() },
            onboardingView: { WelcomeView() }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
    }
}

//MARK: - Methods
///Methods
extension AppView {
    private func checkUserStatus() async {
        if let auth = authManager.auth {
            //TODO: Fetch user here and populate
            isPerformingTask.toggle()
        }
        else {
            print("Not signed in")
            isPerformingTask.toggle()
        }
    }
}

#Preview("AppView - TabBar") { 
    AppView(appState: AppState(isSignedIn: true))
        .environment(AuthManager(service: MockAuthService(user: .sample())))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(isSignedIn: false))
        .environment(AuthManager(service: MockAuthService(user: nil)))

}
