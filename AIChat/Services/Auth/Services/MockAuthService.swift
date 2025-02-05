//
//  MockAuthService.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import Foundation

struct MockAuthService: AuthService {
    let currentUser: UserAuthInfo?
    
    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }
    
    func addAuthListener(_ listener: (NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            continuation.yield(currentUser)
        }
    }
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnonymously() async throws -> UserAuthInfo {
        UserAuthInfo.sample()
    }
    
    func signOut() throws {
        
    }
    
    func deleteAccount() async throws {
        
    }
}
