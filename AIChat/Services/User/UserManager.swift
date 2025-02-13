//
//  UserManager.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import Foundation


@Observable
class UserManager {
    private let service: UserService
    private(set) var currentUser: UserModel?
    private var listenerTask: Task<Void, Error>?
    
    init(service: UserService) {
        self.service = service
        print("------------")
    }
    
    func addStream(to userId: String) {
        listenerTask = Task {
            do {
                for try await value in service.addStream(to: userId) {
                    self.currentUser = value
                    print("Successfully added listener to user")
                }
            }
            catch {
                print("Error with adding listner to user: \(error)")
            }
        }
    }
    
    func signOut() {
        currentUser = nil
        listenerTask?.cancel()
        listenerTask = nil
    }
    
    func save(_ user: UserModel) async throws {
        try await service.saveUser(user)
    }
    
    func deleteUser(with id: String) async throws {
        try await service.deleteUser(with: id)
        signOut()
    }
    
    func addAvatarToMostRecent(_ avatarId: String, to userId: String) async throws {
        try await service.addAvatarToMostRecents(avatarId, to: userId)
    }
    
    func getMostRecentAvatars(for userId: String) async throws -> [MostRecentAvatarModel] {
        try await service.getMostRecentAvatars(for: userId)
    }
}
