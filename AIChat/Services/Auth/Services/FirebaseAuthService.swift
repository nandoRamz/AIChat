//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Nando on 2/2/25.
//

import FirebaseAuth
import SwiftUI

struct FirebaseAuthService: AuthService {
    func addAuthListener(_ listener: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            let newListener = Auth.auth().addStateDidChangeListener { _, user in
                if let user {
                    continuation.yield(UserAuthInfo(user: user))
                }
                else {
                    continuation.yield(nil)
                }
            }
            
            listener(newListener)
        }
    }
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        guard let user = Auth.auth().currentUser else { return nil }
        return UserAuthInfo(user: user)
    }
    
    func signInAnonymously() async throws -> UserAuthInfo {
        let result = try await Auth.auth().signInAnonymously()
        return UserAuthInfo(user: result.user)
    }
    
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        try await Auth.auth().currentUser?.delete()
    }
}
