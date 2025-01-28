//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        VStack {
            Text("Onboarding Completed")
                .frame(maxHeight: .infinity)
            
            finishButton
        }
        .padding()
    }
}

//MARK: - Views
///Views
extension OnboardingCompletedView {
    private var finishButton: some View {
        Button(action: { onFinishPress() }) {
            Text("Finish")
                .mainButtonStyle()
        }
    }
}

//MARK: - Actions
///Actions
extension OnboardingCompletedView {
    private func onFinishPress() {
        appState.updateViewState(isSignedIn: true)
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
