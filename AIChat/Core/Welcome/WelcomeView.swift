//
//  WelcomeView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .frame(maxHeight: .infinity)
                
                NavigationLink {
                    OnboardingCompletedView()
                } label: {
                    Text("Get Started")
                        .mainButtonStyle()
                }
                .padding()
            }
        }
    }
}

#Preview {
    WelcomeView()
}


