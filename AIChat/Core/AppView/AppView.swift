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
    @State private var isPerformingTask: Bool = false
    
    var body: some View {
        AppViewBuilder(
            isSignedIn: appState.isSignedIn,
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
        if let user = authManager.auth {
        }
        else {
            do {
                let result = try await authManager.signInAnonymously()
                print("Sign in Anonymously Success: \(result.uid)")
            }
            catch {
                print("Error: Sign in Anonymously")
            }
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
