//
//  AvatarManager.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

@Observable
class AvatarManager {
    let service: AvatarService
    private(set) var currentUserAvatars: [AvatarModel]?
    private var listenerTask: Task<Void, Error>?

    init(service: AvatarService) {
        self.service = service
    }
    
    func save(_ avatar: AvatarModel, withImage: UIImage) async throws {
        try await service.save(avatar, withImage: withImage)
    }
    
    func getFeatureAvatars() async throws -> [AvatarModel] {
        return try await service.getFeaturedAvatars()
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        return try await service.getPopularAvatars()
    }
    
    func getAvatars(for userId: String) async throws -> [AvatarModel] {
        return try await service.getAvatars(for: userId)
    }
    
    func softDeleteAvatar(withId avatarId: String) async throws {
        try await service.updateIsActiveField(for: avatarId, with: false)
    }
    
    func updatePrivateField(for avatarId: String, with value: Bool) async throws {
        try await service.updateIsPrivateField(for: avatarId, with: value)
    }
}
