//
//  AppView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI



struct AppView: View {
    @State var isSignedIn: Bool = false
    @State private var isPerformingTask: Bool = false
    
    var body: some View {
        AppViewBuilder(
            isSignedIn: isSignedIn,
            isPerformingTask: isPerformingTask,
            tabBarView: { TabBarView() },
            onboardingView: { WelcomeView() }
        )
    }
}

#Preview("AppView - TabBar") {
    AppView(isSignedIn: true)
}

#Preview("AppView - Onboarding") {
    AppView(isSignedIn: false)
}
