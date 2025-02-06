//
//  FirebaseStorageService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import Foundation

protocol MediaUploadService {
    
}

import SwiftUI
import FirebaseStorage
struct FirebaseStorageService: MediaUploadService {
    func saveImage(_ image: UIImage, to path: String) async throws -> URL {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: path)
        
        do {
            let imageUrl = try await image.createTempUrl()
            let _ = try await ref.putFileAsync(from: imageUrl, metadata: metadata)
        }
        catch {
            print(error)
            throw FirestoreStorageError.unableToUploadMedia
        }
        
        return try await ref.downloadURL()
    }
    
    enum FirestoreStorageError: AnyAlertError {
        case unableToUploadMedia
        
        var title: String { "Uploading" }
        var message: String { "We are unable to upload the media at the moment."}
    }
}
