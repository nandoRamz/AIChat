//
//  FirestoreUserService.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import SwiftUI
import FirebaseFirestore

struct FirestoreUserService: UserService {
    var encoder = Firestore.Encoder()
    
    private let usersCollection = Firestore.firestore().collection("users")
    private func userRecentAvatarsCollection(_ userId: String) -> CollectionReference {
        usersCollection.document(userId).collection("most_recent_avatars")
    }
    
    func saveUser(_ user: UserModel) async throws {
        let data = try encoder.encode(user)
        
        try await usersCollection.document(user.id).setData(data, merge: true)
    }
        
    func addStream(to userId: String) -> AsyncThrowingStream<UserModel?, Error> {
        return usersCollection.document(userId).streamDoc()
    }
    
    func deleteUser(with userId: String) async throws {
        try await usersCollection.document(userId).delete()
    }
    
    func addAvatarToMostRecents(_ avatarId: String, to userId: String) async throws {
        try await userRecentAvatarsCollection(userId).document(avatarId).setData([
            "avatar_id": avatarId,
            "timestamp": Timestamp()
        ], merge: true)
    }
    
    func getMostRecentAvatars(for userId: String) async throws -> [MostRecentAvatarModel] {
        try await userRecentAvatarsCollection(userId)
            .order(by: "timestamp")
            .limit(to: 25).getDocuments()
            .docType(MostRecentAvatarModel.self)
    }
}
