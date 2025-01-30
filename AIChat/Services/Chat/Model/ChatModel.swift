//
//  ChatModel.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import Foundation

struct ChatModel: Identifiable, Hashable {
    let id: String
    let userId: String
    let avatarId: String
    let timestamp: Date
    let lastMessageTimestamp: Date
}

extension ChatModel {
    static var sample: ChatModel = samples[0]
    
    static var samples: [ChatModel] = [
        ChatModel(
            id: "chat_001",
            userId: "user_123",
            avatarId: "avatar_abc",
            timestamp: Date(timeIntervalSince1970: 1_700_000_000), // Example date
            lastMessageTimestamp: Date(timeIntervalSince1970: 1_700_000_500)
        ),
        ChatModel(
            id: "chat_002",
            userId: "user_456",
            avatarId: "avatar_xyz",
            timestamp: Date(timeIntervalSince1970: 1_700_100_000),
            lastMessageTimestamp: Date(timeIntervalSince1970: 1_700_100_300)
        ),
        ChatModel(
            id: "chat_003",
            userId: "user_789",
            avatarId: "avatar_lmn",
            timestamp: Date(timeIntervalSince1970: 1_700_200_000),
            lastMessageTimestamp: Date(timeIntervalSince1970: 1_700_200_800)
        ),
        ChatModel(
            id: "chat_004",
            userId: "user_101",
            avatarId: "avatar_pqr",
            timestamp: Date(timeIntervalSince1970: 1_700_300_000),
            lastMessageTimestamp: Date(timeIntervalSince1970: 1_700_301_200)
        )
    ]
}
