//
//  OnboardingIntroView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct OnboardingIntroView: View {
    var body: some View {
        VStack {
            descriptionText

            continueNavLink
        }
        .padding()
    }
}

//MARK: - Views
///Views
extension OnboardingIntroView {
    private var continueNavLink: some View {
        NavigationLink {
            OnboardingColorView()
        } label: {
            Text("Continue")
                .mainButtonStyle()
        }
    }
    
    private var descriptionText: some View {
        Group {
            Text("Make your own ")
            +
            Text("avatars ")
                .foregroundStyle(.accent)
                .fontWeight(.semibold)
            +
            Text("and chat with them!\n\nHave ")
            +
            Text("real conversations ")
                .foregroundStyle(.accent)
                .fontWeight(.semibold)
            +
            Text("with AI generated responses.")
        }
        .frame(maxHeight: .infinity)
        .baselineOffset(8)
        .font(.title3)
    }
}

#Preview {
    NavigationStack {
        OnboardingIntroView()
    }
}
