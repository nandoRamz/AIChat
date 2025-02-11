//
//  ProfileView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserManager.self) private var userManager
    
    @State private var isShowingSettings: Bool = false
    @State private var isShowingCreateAvatarView: Bool = false
    @State private var isShowingAvatarConfirmationDialog: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    let currentUser = userManager.currentUser
                    
                    Circle()
                        .fill(currentUser?.getProfileColor() ?? .accentColor)
                        .frame(width: 100, height: 100)
                    
                    MyAvatarsSectionViewBuilder(
                        onCreateAvatarPress: { onCreateAvatarPress() }
                    )
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .contentMargins(.horizontal, 16)
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
            .navigationDestination(isPresented: $isShowingSettings) {
                SettingsView()
            }
            .navigationDestination(isPresented: $isShowingCreateAvatarView) {
                CreateAvatarView()
                    .navigationBarBackButtonHidden()
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
    private func onCreateAvatarPress() { isShowingCreateAvatarView.toggle() }
    
    private func onSettingsPress() { isShowingSettings.toggle() }
}


#Preview {
    ProfileView()
        .environment(AvatarManager(service: MockAvatarService()))
        .environment(AuthManager(service: MockAuthService()))
        .environment(UserManager(service: MockUserService()))
}
