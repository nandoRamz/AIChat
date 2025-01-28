//
//  ProfileView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var isShowingSettings: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
                .navigationDestination(isPresented: $isShowingSettings) {
                    ZStack {
                        Color.gray
                            .navigationBarTitleDisplayMode(.inline)
                        
                        Text("Settings View")
                    }
                }
        }
        
    }
}

//MARK: - Views
///Views
extension ProfileView {
    private var settingsButton: some View {
        Button(action: { onSettingsPress() }) {
            Image(systemName: "gear")
        }
    }
}

//MARK: - Actions
///Actions
extension ProfileView {
    private func onSettingsPress() { isShowingSettings.toggle() }
}

#Preview {
    ProfileView()
}
