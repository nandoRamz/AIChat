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
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(_ user: UserModel) async throws {
        let data = try encoder.encode(user)
        
        try await collection.document(user.id).setData(data, merge: true)
    }
        
    func addStream(to userId: String) -> AsyncThrowingStream<UserModel?, Error> {
        return collection.document(userId).streamDoc()
    }
    
    func deleteUser(with userId: String) async throws {
        try await collection.document(userId).delete()
    }
}
