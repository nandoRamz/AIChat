//
//  ChatMessageListView.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import SwiftUI

struct ChatMessageListView: View {
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    @State private var messageText: String = ""
    @State private var messages: [ChatMessageModel] = ChatMessageModel.samples
//    @State private var avatar: AvatarModel = .sample
    @State private var currentUser: UserModel? = .sample
    @State private var lastMessageId: String?  
    @State private var error: AnyAlertError?
    @State private var isShowingAvatarModal: Bool = false
    
    var avatar: AvatarModel
 
    var body: some View {
        VStack(spacing: 0) {
            list
                .padding(.bottom, -22)
            
            messageField
        }
        .animation(.easeInOut, value: messages.count)
        .showModal(isPresented: $isShowingAvatarModal) {
            AvatarProfileModal(
                imageUrlString: avatar.imageUrl,
                title: avatar.name,
                subtitle: avatar.characterDescription()
            )
        }
        .navigationTitle(avatar.name ?? "Messages")
        .navigationBarTitleDisplayMode(.inline)
        .errorAlert($error)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Report", role: .destructive, action: {})
                    Button("Delete Chat", role: .destructive, action: {})
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .task {
            addUserViewToAvatar()
            addAvatarToUserRecents()
        }
    }
}


//MARK: - Views
///Views
extension ChatMessageListView {
    private var messageField: some View {
        HStack {
            TextField("Message", text: $messageText)
                .padding(.leading)
            
            Image(systemName: "paperplane.fill")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 16)
                .background(.red)
                .clipShape(.capsule)
                .padding(.all, 4)
                .onTapGesture { onMessageSendPress() }
                .opacity(messageText.isEmpty ? 0 : 1)

        }
        .frame(height: 44)
        .background(.ultraThinMaterial)
        .clipShape(.capsule)
        .padding(.horizontal)
    }
    
    private var list: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(messages) { message in
                    ChatMessageCell(
                        imageUrlString: avatar.imageUrl,
                        text: message.content ?? "" ,
                        foregroundStyle: getMessageForegroundStyle(message),
                        background: getMessageBackground(message),
                        alignment: isCurrentUserMessage(message) ? .trailing : .leading,
                        onAvatarPress: { onAvatarPress() }
                    )
                    .id(message.id)
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .contentMargins(.bottom, 22 + 16)
        .scrollPosition(id: $lastMessageId, anchor: .bottom)
        .defaultScrollAnchor(.bottom)
        
    }
}

//MARK: - Actions
///Actions
extension ChatMessageListView {
    private func onAvatarPress() { isShowingAvatarModal.toggle() }
    
    private func onMessageSendPress() {
        do {
            try checkMessage()
            
            let newMessage = ChatMessageModel(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                createdBy: currentUser?.id,
                content: messageText,
                seenByIds: [],
                timestamp: .now
            )
            
            messages.append(newMessage)
            lastMessageId = newMessage.id
            messageText = ""
        }
        catch {
            guard let err = error as? AnyAlertError else { return }
            self.error = err
        }
    }
}

//MARK: - Methods
///Methods
extension ChatMessageListView {
    private func addUserViewToAvatar() {
        Task {
            do {
                try await avatarManager.addUserView(try authManager.getId(), to: avatar.id)
            }
            catch {
                print("Error with adding user view to avatar: \(error)")
            }
        }
    }
    
    private func addAvatarToUserRecents() {
        Task {
            do {
                try await userManager.addAvatarToMostRecent(
                    avatar.id,
                    to: try authManager.getId()
                )
            }
            catch {
                print("Error with adding avatar to users most recent: \(error)")
            }
        }
    }
    
    private func isCurrentUserMessage(_ message: ChatMessageModel) -> Bool {
        message.createdBy == currentUser?.id
    }
    
    private func getMessageBackground(_ message: ChatMessageModel) -> AnyShapeStyle {
        isCurrentUserMessage(message) ? AnyShapeStyle(Color.accent) : AnyShapeStyle(.ultraThinMaterial)
    }
    
    private func getMessageForegroundStyle(_ message: ChatMessageModel) -> Color {
        isCurrentUserMessage(message) ? .white : .primary
    }
    
    private func checkMessage() throws {
        let badWords = ["bitch", "ass", "dick"]
        let messageComponents = messageText.components(separatedBy: " ")
        
        if messageText.count < 3 { throw SendMessageError.toShort(min: 3) }
        
        let containsBadWord = messageComponents.contains { badWords.contains($0.lowercased()) }
        if containsBadWord { throw SendMessageError.containsProfanity }
    }
}

//MARK: - Enums
///Enums
extension ChatMessageListView {
    enum SendMessageError: AnyAlertError {
        case toShort(min: Int)
        case containsProfanity
        
        var title: String {
            "Unable to send message"
        }
        
        var message: String {
            switch self {
            case .toShort(let min):
                "Please enter a message with at least \(min) characters long."
            case .containsProfanity:
                "This message contains profanity please try again."
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatMessageListView(avatar: .sample)
            .environment(AvatarManager(service: MockAvatarService()))
            .environment(AuthManager(service: MockAuthService(user: .sample())))
            .environment(UserManager(service: MockUserService()))
    }
}

/*
 VStack {
     ImageLoaderView(urlString: avatar.imageUrl)
         .aspectRatio(1, contentMode: .fit)
     
     VStack(alignment: .leading) {
         Text("Some Title")
             .font(.headline)
         
         Text("Some Title")
             .font(.subheadline)
             .foregroundStyle(.secondary)
     }
     .frame(maxWidth: .infinity, alignment: .leading)
     .padding()
 }
 .background(.ultraThinMaterial)
 .clipShape(.rect(cornerRadius: 15))
 .padding(.horizontal, 40)
 .offset(x: isShowingAvatarModal ? 0 : -1000)
 */

/*
 ZStack {
     if isShowingAvatarModal {
             Color.black.opacity(0.5)
                 .ignoresSafeArea()
                 .onTapGesture { isShowingAvatarModal.toggle() }
             
             
             .padding(.horizontal, 40)
             .transition(.move(edge: .leading))
     }
 }
 */
