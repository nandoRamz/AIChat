//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var appState
    @State private var isPerformingTask: Bool = false
    var selectedColor: Color = .teal
    
    var body: some View {
        message
            .frame(maxHeight: .infinity)
            .padding()
            .safeAreaInset(edge: .bottom) {
                finishButton
                    .padding()
            }
    }
}

//MARK: - Views
///Views
extension OnboardingCompletedView {
    private var finishButton: some View {
        Button(action: { onFinishPress() }) {
            Group {
                if isPerformingTask { ProgressView().tint(.white) }
                else { Text("Finished") }
            }
            .mainButtonStyle()
        }
    }
    
    private var message: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Setup Complete!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(selectedColor)
            
            Text("We've set up your profile and you're ready to start chatting.")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }
}

//MARK: - Actions
///Actions
extension OnboardingCompletedView {
    private func onFinishPress() {
        if isPerformingTask { return }
        isPerformingTask.toggle()
        
        Task {
            try await Task.sleep(for: .seconds(1))
            isPerformingTask.toggle()
            
            appState.updateViewState(isSignedIn: true)
        }
        
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
