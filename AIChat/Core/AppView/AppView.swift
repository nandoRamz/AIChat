//
//  AppView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI



struct AppView: View {
    @State private var isSignedIn: Bool = false
    @State private var isPerformingTask: Bool = false
    
    var body: some View {
        AppViewBuilder(
            isSignedIn: isSignedIn,
            isPerformingTask: isPerformingTask,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Onboarding")
                }
            },
            onboardingView: {
                ZStack {
                    Color.green.ignoresSafeArea()
                    Text("Logged In")
                }
            }
        )
    }
}

#Preview {
    AppView()
}
