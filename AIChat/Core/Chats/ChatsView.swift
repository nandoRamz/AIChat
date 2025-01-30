//
//  ChatsView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.samples
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(chats) { chat in
                        ChatCellViewBuilder(
                            currentUserId: "",
                            chat: chat,
                            getAvatar: {
                                try? await Task.sleep(for: .seconds(1))
                                return AvatarModel.sample
                            },
                            getLastChatMessage: {
                                try? await Task.sleep(for: .seconds(1))
                                return ChatMessageModel.sample
                            }
                        )
                        .padding(.vertical, 11)
                        .padding(.horizontal)
                        .background(
                            Divider()
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .opacity(chat == chats.last ? 0 : 1)
                        )
                    }
                }
                .background()
                .clipShape(.rect(cornerRadius: 15))
                .padding(.horizontal)
                
            }
            .background(Color(uiColor: .secondarySystemBackground))
            .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatsView()
}
