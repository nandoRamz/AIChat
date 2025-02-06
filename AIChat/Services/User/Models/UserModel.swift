//
//  UserModel.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import SwiftUI

struct UserModel: Codable {
    let id: String
    let email: String?
    let isAnonymous: Bool?
    let lastActive: Date
    let memberSince: Date
    let name: String? = nil 
    
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        id: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        lastActive: Date,
        memberSince: Date,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String?
    ) {
        self.id = id
        self.email = email
        self.isAnonymous = isAnonymous
        self.lastActive = lastActive
        self.memberSince = memberSince
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    static func createNewUser(from authInfo: UserAuthInfo) -> Self {
        .init(
            id: authInfo.uid,
            email: authInfo.email,
            isAnonymous: authInfo.isAnonymous,
            lastActive: .now,
            memberSince: .now,
            didCompleteOnboarding: nil,
            profileColorHex: nil
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case isAnonymous = "is_anonymous"
        case lastActive = "last_active"
        case memberSince = "member_since"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
    }
}

//MARK: - Methods
///Methods
extension UserModel {
    func getProfileColor() -> Color {
        guard let profileColorHex,
              let color = Color.init(hex: profileColorHex)
        else { return Color.accentColor }
        
        return color
    }
}

extension UserModel {
    static var sample: UserModel = samples[0]
    
    static let samples: [UserModel] = [
        UserModel(
            id: "user_456",
            lastActive: .now,
            memberSince: Date(),
            didCompleteOnboarding: true,
            profileColorHex: "#4287f5"
        ),
        UserModel(
            id: "user_002",
            lastActive: .now,
            memberSince: Date().addingTimeInterval(-86400),
            didCompleteOnboarding: false,
            profileColorHex: "#FF5733"
        ),
        UserModel(
            id: "user_003",
            lastActive: .now,
            memberSince: Date().addingTimeInterval(-604800),
            didCompleteOnboarding: true,
            profileColorHex: nil
        ),
        UserModel(
            id: "user_004",
            lastActive: .now,
            memberSince: Date().addingTimeInterval(-2592000),
            didCompleteOnboarding: false,
            profileColorHex: "#2ecc71"
        )
    ]
}
