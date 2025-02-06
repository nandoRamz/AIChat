//
//  FirestoreAvatarService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI
import FirebaseFirestore

struct FirestoreAvatarService: AvatarService {
    var encoder = Firestore.Encoder()
    
    var avatarsCollection = Firestore.firestore().collection(FirestoreCollections.avatars)
    var usersCollections = Firestore.firestore().collection(FirestoreCollections.users)
    
    func save(_ avatar: AvatarModel, withImage image: UIImage, isPrivate: Bool) async throws {
        guard let userId = avatar.authorId else { return }
        var mutableCopy = avatar
        let timestamp = Timestamp()
        
        let newId = avatarsCollection.document().documentID
        mutableCopy.updateId(with: newId)
        
        let newDate = timestamp.dateValue()
        mutableCopy.updateTimestamp(with: newDate)
        
        let reference = switch isPrivate {
        case true: usersCollections.document(userId).collection(FirestoreCollections.avatars)
        case false: avatarsCollection
        }
        
        let imagePath = "avatars/\(newId)"
        let imageUrl = try await FirebaseStorageService().saveImage(image, to: imagePath)
        mutableCopy.updateImageUrl(with: imageUrl.absoluteString)
        
        let data = try encoder.encode(mutableCopy)
        try await reference.document(newId).setData(data, merge: true)
    }
}
