//
//  MockAvatarService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

struct MockAvatarService: AvatarService {
    func updateIsPrivateField(for avatarId: String, with value: Bool) async throws {
        
    }
    
    func updateIsActiveField(for avatarId: String, with value: Bool) async throws {

    }
    
    func save(_ avatar: AvatarModel, withImage image: UIImage) async throws {
        
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(3))
        return AvatarModel.samples
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(4))
        return AvatarModel.samples
    }
    
    func getAvatars(for category: CharacterOption) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(4))
        return AvatarModel.samples
    }
    
    func getAvatars(for userId: String) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(4))
        return AvatarModel.samples
    }
    
    func addUserView( _ userId: String, to avatarId: String) async throws {

    }
    
    func updateViewCountField(for avatarId: String, checking userId: String) async throws {
        
    }
    
    func getAvatars(with ids: [String]) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(4))
        return AvatarModel.samples
    }
}
