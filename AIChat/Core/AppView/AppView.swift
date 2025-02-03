//
//  AppView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct AppView: View {
    @Environment(\.authService) private var authService
    
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
        if let user = authService.getAuthenticatedUser() {
            print("User already authenticated: \(user.uid)")
        }
        else {
            do {
                let result = try await authService.signInAnonymously()
                print("Sign in Anonymously Success: \(result.user.uid)")
            }
            catch {
                print("Error: Sign in Anonymously")
            }
        }
    }
}

#Preview("AppView - TabBar") { 
    AppView(appState: AppState(isSignedIn: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(isSignedIn: false))
}
