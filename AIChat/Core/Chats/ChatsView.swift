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
                        Text(chat.id)
                            .padding(.vertical, 11)
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
