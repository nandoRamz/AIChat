//
//  AppView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct AppView: View {
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
    }
}

#Preview("AppView - TabBar") { 
    AppView(appState: AppState(isSignedIn: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(isSignedIn: false))
}
