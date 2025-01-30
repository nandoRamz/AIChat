//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import Foundation

struct ChatMessageModel {
    let id: String
    let chatId: String
    let authorId: String?
    let content: String?
    let seenByIds: [String]?
    let timestamp: Date?
}

extension ChatMessageModel {
    static var sample: ChatMessageModel = samples[0]
    
    static var samples: [ChatMessageModel] = [
        ChatMessageModel(
            id: "msg_001",
            chatId: "chat_001",
            authorId: "user_123",
            content: "Hey! How are you?",
            seenByIds: ["user_456", "user_789"],
            timestamp: Date(timeIntervalSince1970: 1_700_000_000)
        ),
        ChatMessageModel(
            id: "msg_002",
            chatId: "chat_001",
            authorId: "user_456",
            content: "I'm good, how about you?",
            seenByIds: ["user_123"],
            timestamp: Date(timeIntervalSince1970: 1_700_000_500)
        ),
        ChatMessageModel(
            id: "msg_003",
            chatId: "chat_002",
            authorId: "user_789",
            content: "Are we meeting tomorrow?",
            seenByIds: nil, // No one has seen this message yet
            timestamp: Date(timeIntervalSince1970: 1_700_100_000)
        ),
        ChatMessageModel(
            id: "msg_004",
            chatId: "chat_002",
            authorId: nil, // System message or deleted author
            content: "This message was deleted.",
            seenByIds: ["user_101", "user_102"],
            timestamp: Date(timeIntervalSince1970: 1_700_100_800)
        ),
        ChatMessageModel(
            id: "msg_005",
            chatId: "chat_003",
            authorId: "user_555",
            content: nil, // Possible empty content scenario
            seenByIds: ["user_333"],
            timestamp: Date(timeIntervalSince1970: 1_700_200_500)
        )
    ]
}
