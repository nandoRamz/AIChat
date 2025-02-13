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
    private(set) var currentUserAvatars: [AvatarModel] = []
    private var listenerTask: Task<Void, Error>?

    init(service: AvatarService) {
        self.service = service
    }
    
    func save(_ avatar: AvatarModel, withImage: UIImage) async throws {
        guard let userId = avatar.createdBy else { return }
        try await service.save(avatar, withImage: withImage)
        try await updateCurrentUserAvatars(for: userId)
    }
    
    func getFeatureAvatars() async throws -> [AvatarModel] {
        return try await service.getFeaturedAvatars()
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        return try await service.getPopularAvatars()
    }
    
    func deleteAvatar(_ avatar: AvatarModel) async throws {
        guard let userId = avatar.createdBy else { return }
        try await service.updateIsActiveField(for: avatar.id, with: false)
        currentUserAvatars.removeAll(where: {$0 == avatar})
        try await updateCurrentUserAvatars(for: userId)
    }
    
    func updatePrivateField(for avatarId: String, with value: Bool) async throws {
        try await service.updateIsPrivateField(for: avatarId, with: value)
    }
    
    func updateCurrentUserAvatars(for userId: String) async throws {
        self.currentUserAvatars = try await service.getAvatars(for: userId)
    }
    
    func addUserView(_ userId: String, to avatarId: String) async throws {
        try await service.updateViewCountField(for: avatarId, checking: userId)
        try await service.addUserView(userId, to: avatarId)
    }
    
    func getAvatars(with ids: [String]) async throws -> [AvatarModel] {
        try await service.getAvatars(with: ids)
    }
    
    func orderMostRecentAvatars(_ mostRecentAvatars: [MostRecentAvatarModel], using avatars: [AvatarModel]) -> [AvatarModel] {
        var orderAvatars: [AvatarModel] = []
        for avatar in mostRecentAvatars {
            if let matchingAvatar = avatars.first(where: {$0.id == avatar.avatarId}) {
                orderAvatars.append(matchingAvatar)
            }
        }
        return orderAvatars.reversed()
    }
}
