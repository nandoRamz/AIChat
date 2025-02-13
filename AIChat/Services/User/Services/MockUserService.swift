//
//  MockUserService.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import Foundation

struct MockUserService: UserService {
    func deleteUser(with userId: String) async throws {
        
    }
    
    func saveUser(_ user: UserModel) async throws {
        
    }
    
    func addStream(to userId: String) -> AsyncThrowingStream<UserModel?, Error> {
        return AsyncThrowingStream { continuation in
            continuation.yield(UserModel.sample)
        }
    }
    
    func addAvatarToMostRecents(_ avatarId: String, to userId: String) async throws {
        
    }
    
    func getMostRecentAvatars(for userId: String) async throws -> [MostRecentAvatarModel] {
        try await Task.sleep(for: .seconds(3))
        return AvatarModel.samples.map { MostRecentAvatarModel(avatarId: $0.id, timestamp: $0.timestamp ?? .now)}
    }
}
