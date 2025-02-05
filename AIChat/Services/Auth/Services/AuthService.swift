//
//  AuthService.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import SwiftUI

protocol AuthService {
    func addAuthListener(_ listener: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?>
    
    func getAuthenticatedUser() -> UserAuthInfo?
    
    func signInAnonymously() async throws -> UserAuthInfo
    
    func signOut() throws
    
    func deleteAccount() async throws
}
