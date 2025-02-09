//
//  TabBarView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct TabBarView: View {
    @Environment(UserManager.self) private var userManager
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarManager.self) private var avatarManager
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem { Label("Explore", systemImage: "magnifyingglass") }
            
            ChatsView()
                .tabItem { Label("Chats", systemImage: "bubble.left.and.bubble.right") }
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
        .onAppear {
            if let userId = authManager.auth?.uid {
                userManager.addStream(to: userId)
            }
        }
    }
}

#Preview {
    TabBarView()
        .environment(UserManager(service: FirestoreUserService()))
        .environment(AuthManager(service: MockAuthService(user: nil)))
}
