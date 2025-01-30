//
//  UserModel.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import SwiftUI

struct UserModel {
    let userId: String
    let didCompleteOnboarding: Bool
    let profileColorHex: String?
    let timestamp: Date
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
            userId: "user_001",
            didCompleteOnboarding: true,
            profileColorHex: "#4287f5",

            timestamp: Date()
        ),
        UserModel(
            userId: "user_002",
            didCompleteOnboarding: false,
            profileColorHex: "#FF5733",
            timestamp: Date().addingTimeInterval(-86400)
        ),
        UserModel(
            userId: "user_003",
            didCompleteOnboarding: true,
            profileColorHex: nil,
            timestamp: Date().addingTimeInterval(-604800)
        ),
        UserModel(
            userId: "user_004",
            didCompleteOnboarding: false,
            profileColorHex: "#2ecc71",
            timestamp: Date().addingTimeInterval(-2592000)
        )
    ]
}
