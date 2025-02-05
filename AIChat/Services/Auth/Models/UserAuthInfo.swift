//
//  UserAuthInfo.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import Foundation

struct UserAuthInfo {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let timestamp: Date?
    let lastSignIn: Date?
    
    init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool,
        timestamp: Date,
        lastSignIn: Date
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.timestamp = timestamp
        self.lastSignIn = lastSignIn
    }
    
    static func sample(isAnonymous: Bool = false) -> Self {
        .init(
            uid: "nando.ramz",
            email: "test1@gmail.com",
            isAnonymous: isAnonymous,
            timestamp: .now,
            lastSignIn: .now
        )
    }
}
