//
//  ChatsView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.samples
    @State private var navManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            ScrollView {
                VStack(spacing: 32) {
                    UserMostRecentAvatarsSectionViewBuilder(
                        onAvatarPress: { avatar in
                            navManager.path.append(avatar)
                        }
                    )
                    
//                    LazyVStack(spacing: 0) {
//                        ForEach(chats) { chat in
//                            ChatCellViewBuilder(
//                                currentUserId: "",
//                                chat: chat,
//                                getAvatar: {
//                                    try? await Task.sleep(for: .seconds(1))
//                                    return AvatarModel.sample
//                                },
//                                getLastChatMessage: {
//                                    try? await Task.sleep(for: .seconds(1))
//                                    return ChatMessageModel.sample
//                                }
//                            )
//                            .padding(.vertical, 11)
//                            .padding(.horizontal)
//                            .background(
//                                Divider()
//                                    .frame(maxHeight: .infinity, alignment: .bottom)
//                                    .opacity(chat == chats.last ? 0 : 1)
//                            )
//                        }
//                    }
//                    .background()
//                    .clipShape(.rect(cornerRadius: 15))
                }
            }
            .contentMargins(.horizontal, 16)
            .background(Color(uiColor: .secondarySystemBackground))
            .navigationTitle("Chats")
            .navigationDestination(for: AvatarModel.self) { value in
                ChatMessageListView(avatar: value)
            }
        }
    }
}

#Preview {
    ChatsView()
        .environment(UserManager(service: MockUserService()))
        .environment(AuthManager(service: MockAuthService(user: .sample())))
        .environment(AvatarManager(service: MockAvatarService()))
}
