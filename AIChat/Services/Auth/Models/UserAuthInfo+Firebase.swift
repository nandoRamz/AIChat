//
//  UserAuthInfo+Firebase.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import FirebaseAuth

extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.timestamp = user.metadata.creationDate
        self.lastSignIn = user.metadata.lastSignInDate
    }
}
