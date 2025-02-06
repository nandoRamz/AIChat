//
//  ChatCellViewBuilder.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import SwiftUI

struct ChatCellViewBuilder: View {
    @State private var avatar: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?
    @State private var didLoadAvater: Bool = false
    @State private var didLoadLastChatMessage: Bool = false
    
    var currentUserId: String = ""
    var chat: ChatModel = .sample
    var getAvatar: () async -> AvatarModel?
    var getLastChatMessage: () async -> ChatMessageModel?
    
    var body: some View {
        let imageUrlString = avatar?.imageUrl
        let title = isLoading() ? "xxxx xxxx" : avatar?.name ?? ""
        let subTitle = isLoading() ? "xxxx xxxx xxxx xxxx" : lastChatMessage?.content ?? ""
        let isShowingBadge = isLoading() ? false : isShowingBadge()
        
        ChatCell(
            imageUrlString: imageUrlString,
            title: title,
            subTitle: subTitle,
            isShowingBadge: isShowingBadge
        )
        .redacted(reason: isLoading() ? .placeholder : [])
        .task {
            avatar = await getAvatar()
            didLoadAvater = true
        }
        .task {
            lastChatMessage = await getLastChatMessage()
            didLoadLastChatMessage = true
        }
    }
}

//MARK: - Methods
///Methods
extension ChatCellViewBuilder {
    private func isLoading() -> Bool {
        if didLoadAvater && didLoadLastChatMessage { return false }
        else { return true }
    }
    
    private func isShowingBadge() -> Bool {
        guard let lastChatMessage else { return false }
        return lastChatMessage.hasBeenSeen(by: currentUserId)
    }
}

#Preview {
    VStack {
        ChatCellViewBuilder(
            currentUserId: "",
            chat: .sample,
            getAvatar: {  return AvatarModel.sample },
            getLastChatMessage: { return ChatMessageModel.sample }
        )
        
        ChatCellViewBuilder(
            currentUserId: "",
            chat: .sample,
            getAvatar: {
                try? await Task.sleep(for: .seconds(3))
                return AvatarModel.sample
            },
            getLastChatMessage: { return ChatMessageModel.sample }
        )
    }
    
    .padding(.horizontal)
}
