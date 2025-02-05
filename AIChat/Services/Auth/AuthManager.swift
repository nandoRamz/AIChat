//
//  AuthManager.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import SwiftUI

//@MainActor
@Observable
class AuthManager {
    private let service: AuthService
    private(set) var auth: UserAuthInfo?
    private var listener: (any NSObjectProtocol)?
    
    init(service: AuthService) {
        self.service = service 
        self.auth = service.getAuthenticatedUser()
        self.addAuthListener()
    }
    
    func addAuthListener() {
        Task {
            for await value in service.addAuthListener({ listener in
                self.listener = listener
            }) {
                self.auth = value
                print("Auth listener succes: \(value?.uid ?? "no uid")")
            }
        }
    }
    
    func getId() throws -> String {
        guard let uid = auth?.uid else { throw AuthManagerError.notSignedIn }
        return uid
    }
        
    func signInAnonymously() async throws -> UserAuthInfo {
        do { return try await service.signInAnonymously() }
        catch { throw AuthManagerError.signInAnonymously }
    }
    
    func signOut() throws {
        do { return try service.signOut() }
        catch { throw AuthManagerError.signingOut }
    }
    
    func deleteAccount() async throws {
        do { return try await service.deleteAccount() }
        catch { throw AuthManagerError.deletingAccount }
    }
}

enum AuthManagerError: Error, AnyAlertError {
    case notSignedIn
    case signInAnonymously
    case signingOut
    case deletingAccount
    
    var message: String {
        switch self {
        case .notSignedIn: "No current user signed in."
        case .signInAnonymously: "Unable to sign in anonymously."
        case .signingOut: "Unable to sign out at the moment."
        case .deletingAccount: "Unable to delete account at the moment."
        }
    }
    
    var title: String {
        switch self {
        case .notSignedIn: "Error"
        case .signInAnonymously: "Error"
        case .signingOut: "Error"
        case .deletingAccount: "Error"
        }
    }
}
