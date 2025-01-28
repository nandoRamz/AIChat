//
//  AppViewBuilder.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct AppViewBuilder<TabbarView: View, OnboardingView: View>: View {
    var isSignedIn: Bool
    var isPerformingTask: Bool
    
    @ViewBuilder var tabbarView: TabbarView
    @ViewBuilder var onboardingView: OnboardingView
    
    var body: some View {
        ZStack {
            if isPerformingTask { Color.clear }
            else {
                ZStack {
                    if isSignedIn {
                        tabbarView
                            .transition(.move(edge: .trailing))
                    }
                    else {
                        onboardingView
                            .transition(.move(edge: .leading))
                    }
                }
                .animation(.easeInOut, value: isSignedIn)
            }
        }
    }
}

#Preview {
    AppViewBuilder(
        isSignedIn: false,
        isPerformingTask: false,
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
