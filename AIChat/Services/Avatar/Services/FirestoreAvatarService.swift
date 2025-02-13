//
//  FirestoreAvatarService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI
import FirebaseFirestore

struct FirestoreAvatarService: AvatarService {
    private let encoder = Firestore.Encoder()
    private let decoder = Firestore.Decoder()
    private let avatarsCollection = Firestore.firestore().collection(FirestoreCollections.avatars)
    private func avatarUsersSubCollection(for avatarId: String) -> CollectionReference {
        avatarsCollection.document(avatarId).collection("users")
    }
    
    func save(_ avatar: AvatarModel, withImage image: UIImage) async throws {
        var mutableCopy = avatar
        let timestamp = Timestamp()
        
        let newId = avatarsCollection.document().documentID
        mutableCopy.updateId(with: newId)
        
        let newDate = timestamp.dateValue()
        mutableCopy.updateTimestamp(with: newDate)
        
        let imagePath = "avatars/\(newId)"
        let imageUrl = try await FirebaseStorageService().saveImage(image, to: imagePath)
        mutableCopy.updateImageUrl(with: imageUrl.absoluteString)
        
        let data = try encoder.encode(mutableCopy)
        try await avatarsCollection.document(newId).setData(data, merge: true)
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        let avatars = try await avatarsCollection
            .whereField(AvatarModelKeys.isActive.rawValue, isEqualTo: true)
            .whereField(AvatarModelKeys.isPrivate.rawValue, isEqualTo: false)
            .order(by: AvatarModelKeys.timestamp.rawValue, descending: true)
            .limit(to: 5)
            .getDocuments()
            .docType(AvatarModel.self)
        
        return avatars.shuffled()
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        let avatars = try await avatarsCollection
            .whereField(AvatarModelKeys.isActive.rawValue, isEqualTo: true)
            .whereField(AvatarModelKeys.isPrivate.rawValue, isEqualTo: false)
            .order(by: AvatarModelKeys.timestamp.rawValue, descending: true)
            .limit(to: 25)
            .getDocuments()
            .docType(AvatarModel.self)
        
        return avatars.shuffled()
    }
    
    func getAvatars(for category: CharacterOption) async throws -> [AvatarModel] {
        let avatars = try await avatarsCollection
            .whereField(AvatarModelKeys.isActive.rawValue, isEqualTo: true)
            .whereField(AvatarModelKeys.isPrivate.rawValue, isEqualTo: false)
            .whereField(AvatarModelKeys.characterOption.rawValue, isEqualTo: category)
            .order(by: AvatarModelKeys.timestamp.rawValue, descending: true)
            .limit(to: 5)
            .getDocuments()
            .docType(AvatarModel.self)
        
        return avatars.shuffled()
    }
    
    func getAvatars(for userId: String) async throws -> [AvatarModel] {
        let avatars = try await avatarsCollection
            .whereField(AvatarModelKeys.createdBy.rawValue, isEqualTo: userId)
            .whereField(AvatarModelKeys.isActive.rawValue, isEqualTo: true)
            .order(by: AvatarModelKeys.timestamp.rawValue, descending: true)
            .limit(to: 25)
            .getDocuments()
            .docType(AvatarModel.self)
        
        return avatars
    }
    
    func updateIsPrivateField(for avatarId: String, with value: Bool) async throws {
        try await avatarsCollection.document(avatarId).setData([
            AvatarModelKeys.isPrivate.rawValue: value
        ], merge: true )
    }
    
    func updateIsActiveField(for avatarId: String, with value: Bool) async throws {
        try await avatarsCollection.document(avatarId).setData([
            AvatarModelKeys.isActive.rawValue: false
        ], merge: true)
    }
    
    func addUserView( _ userId: String, to avatarId: String) async throws {
        try await avatarUsersSubCollection(for: avatarId).document(userId).setData([
            "userId": userId,
            "timestamp": Timestamp()
        ], merge: true)
    }
    
    func updateViewCountField(for avatarId: String, checking userId: String) async throws {
        let doesViewExists = try await avatarUsersSubCollection(for: avatarId).document(userId).getDocument().exists
        if doesViewExists { return }
        try await avatarsCollection.document(avatarId).updateData([
            AvatarModelKeys.viewCount.rawValue: FieldValue.increment(Int64(1))
        ])
    }
    
    func getAvatars(with ids: [String]) async throws -> [AvatarModel] {
        var avatars: [AvatarModel] = []
        
        try await withThrowingTaskGroup(of: AvatarModel.self) { group in

            for id in ids {
                group.addTask {
                    try await getAvatar(with: id)
                }
            }
            
            for try await avatar in group {
                avatars.append(avatar)
            }
        }
        
        return avatars
    }
    
    func getAvatar(with id: String) async throws -> AvatarModel {
        try await avatarsCollection.document(id)
            .docType(AvatarModel.self)
    }
}

