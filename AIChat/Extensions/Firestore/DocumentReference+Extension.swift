//
//  DocumentReference+Extension.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import SwiftUI
import FirebaseFirestore

extension DocumentReference {
    func streamDoc<T: Decodable>() -> AsyncThrowingStream<T?, Error> {
        AsyncThrowingStream { continuation in
            let _ = self.addSnapshotListener { snapshot, error in
                if let error {
                    continuation.finish(throwing: error)
                    return
                }
                
                guard let snapshot else {
                    continuation.yield(nil)
                    return
                }
                
                do {
                    let model = try snapshot.data(as: T.self)

                    continuation.yield(model)
                }
                catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    func docType<T: Decodable>(_ type: T.Type) async throws -> T {
        try await self.getDocument(as: T.self)
    }
}
