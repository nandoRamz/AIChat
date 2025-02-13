//
//  MostRecentAvatarModel.swift
//  AIChat
//
//  Created by Nando on 2/12/25.
//

import Foundation

typealias MostRecentAvatarModelKeys = MostRecentAvatarModel.CodingKeys

struct MostRecentAvatarModel: Codable {
    let avatarId: String
    let timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case avatarId = "avatar_id"
        case timestamp = "timestamp"
    }
}
