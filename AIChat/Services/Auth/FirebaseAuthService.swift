//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Nando on 2/2/25.
//

import FirebaseAuth
import SwiftUI

private struct Key: EnvironmentKey {
    static var defaultValue: FirebaseAuthService = FirebaseAuthService()
}

extension EnvironmentValues {
    var authService: FirebaseAuthService {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}

struct FirebaseAuthService {
    func getAuthenticatedUser() -> User? {
        Auth.auth().currentUser
    }
    
    func signInAnonymously() async throws -> AuthDataResult {
        try await Auth.auth().signInAnonymously()
    }
}
