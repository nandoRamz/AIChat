//
//  QuerySnapshot+Extension.swift
//  AIChat
//
//  Created by Nando on 2/7/25.
//

import FirebaseFirestore

extension QuerySnapshot {
    func docType<T: Decodable>(_ type: T.Type) throws -> [T] {
        let docs = self.documents
        
        return try docs.map { try $0.data(as: T.self) }
    }
}
