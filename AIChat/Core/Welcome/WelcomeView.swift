//
//  WelcomeView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var imageUrlString: String = Constants.randomImageUrlString
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ImageLoaderView(urlString: imageUrlString)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    title
                    
                    getStartedNavLink
                        .padding(.horizontal)
                    
                    signInButton
                        .padding(.all)
                }
            }
        }
    }
}

//MARK: - Views
///Views
extension WelcomeView {
    private var signInButton: some View {
        Button(action: { onSignInPress() }) {
            Text("Already have an account? Sign in.")
        }
    }
    
    private var getStartedNavLink: some View {
        NavigationLink {
            OnboardingIntroView()
        } label: {
            Text("Get Started")
                .mainButtonStyle()
        }
    }
    
    private var title: some View {
        Text("AI Chat")
            .font(.largeTitle)
            .fontWeight(.bold)
    } 
}

//MARK: - Actions
///Actions
extension WelcomeView {
    private func onSignInPress() {
        
    }
}

#Preview {
    WelcomeView()
}


/*
 
 Did not add the links for terms and policy
 HStack {
     Link(destination: URL(string: "https://apple.com")!) {
         Text("Terms of Service")
     }
     
     Circle()
         .fill(.accent)
         .frame(width: 4, height: 4)

     Link(destination: URL(string: "https://apple.com")!) {
         Text("Privacy Policy")
     }
 }
 */
