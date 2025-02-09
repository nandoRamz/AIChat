//
//  AvatarService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

protocol AvatarService {
    func save(_ avatar: AvatarModel, withImage image: UIImage) async throws
    func getFeaturedAvatars() async throws -> [AvatarModel]
    func getPopularAvatars() async throws -> [AvatarModel] 
    func getAvatars(for category: CharacterOption) async throws -> [AvatarModel]
    func getAvatars(for userId: String) async throws -> [AvatarModel]
    func updateIsPrivateField(for avatarId: String, with value: Bool) async throws
    func updateIsActiveField(for avatarId: String, with value: Bool) async throws
}
