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
    
    init() {
        FirebaseApp.configure()
        _authManager = State(wrappedValue: AuthManager(service: FirebaseAuthService()))
        _userManager = State(wrappedValue: UserManager(service: FirestoreUserService()))
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(authManager)
                .environment(userManager)
        }
    }
}

