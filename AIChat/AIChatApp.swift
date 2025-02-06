//
//  AIChatApp.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI
import Firebase

@main
struct AIChatApp: App {
    @State private var authManager: AuthManager
    @State private var userManager: UserManager
    @State private var aiImageGeneratorManager: AIImageGeneratorManager
    @State private var avatarManager: AvatarManager
    
    init() {
        FirebaseApp.configure()
        _authManager = State(wrappedValue: AuthManager(service: FirebaseAuthService()))
        _userManager = State(wrappedValue: UserManager(service: FirestoreUserService()))
        _aiImageGeneratorManager = State(wrappedValue: AIImageGeneratorManager(service: GetImgAIService()))
        _avatarManager = State(wrappedValue: AvatarManager(service: FirestoreAvatarService()))
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(authManager)
                .environment(userManager)
                .environment(aiImageGeneratorManager)
                .environment(avatarManager)
        }
    }
}

