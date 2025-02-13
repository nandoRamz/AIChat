//
//  UserService.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import Foundation

protocol UserService {
    func saveUser(_ user: UserModel) async throws
    
    func addStream(to userId: String) -> AsyncThrowingStream<UserModel?, Error>
    
    func deleteUser(with userId: String) async throws
    
    func addAvatarToMostRecents(_ avatarId: String, to userId: String) async throws 
    func getMostRecentAvatars(for userId: String) async throws -> [MostRecentAvatarModel]
}
