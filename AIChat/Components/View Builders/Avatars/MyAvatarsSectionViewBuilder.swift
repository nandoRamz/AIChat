//
//  MyAvatarsSectionViewBuilder.swift
//  AIChat
//
//  Created by Nando on 2/10/25.
//

import SwiftUI

struct MyAvatarsSectionViewBuilder: View {
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(AuthManager.self) private var authManager
    
//    @State private var avatars: [AvatarModel] = []
    @State private var didFinishFetchingAvatars: Bool = false
    @State private var selectedAvatar: AvatarModel?
    @State private var isShowingDeleteConfirmationDialog: Bool = false
    private var isPreview: Bool = false
    private var avatars: [AvatarModel] {
        avatarManager.currentUserAvatars
    }
    
    var onCreateAvatarPress: (() -> Void)?
    
    ///Only used for Xcode Previews
    init(
        avatars: [AvatarModel],
        didFinishFetchingAvatars: Bool
    ) {
//        _avatars = State(wrappedValue: avatars)
        _didFinishFetchingAvatars = State(wrappedValue: didFinishFetchingAvatars)
        isPreview = true
    }
    
    init(
        onCreateAvatarPress: (() -> Void)? = nil
    ) {
        self.onCreateAvatarPress = onCreateAvatarPress
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .lastTextBaseline) {
                ListTitleView(text: "My Avatars")
                
                createNewAvatarButton
            }
            
            if !didFinishFetchingAvatars {
                loadingView
            }
            else {
                if avatars.isEmpty {
                    NoResultsView(
                        message: "It looks like you dont have any avatars. You can always add a new avatar by pressing the button above.",
                        height: 200
                    )
                }
                else {
                    avatarsView
                }
            }
        }
        .onAppear {
            if didFinishFetchingAvatars { return }
            getMyAvatars()
        }
        .confirmationDialog(
            "",
            isPresented: $isShowingDeleteConfirmationDialog,
            titleVisibility: .hidden,
            presenting: selectedAvatar,
            actions: { _ in
                avatarDeleteConfirmationDialogActions
            },
            message: { _ in
                Text("Are you sure you would like to delete this avatar?")
            }
        )
    }
}

//MARK: - Views
///Views
extension MyAvatarsSectionViewBuilder {
    private var avatarsView: some View {
        LazyVStack(spacing: 0) {
            ForEach(avatars, id: \.self) { avatar in
                MyAvatarCellBuilder(
                    isLoading: !didFinishFetchingAvatars,
                    avatar: avatar,
                    onMenuItemPress: { action in
                        onAvatarMenuActionPress(action, avatar: avatar)
                    }
                )
                .padding(.vertical, 11)
            }
        }
    }
    
    private var loadingView: some View {
        LazyVStack(spacing: 0) {
            ForEach(0..<10) { _ in
                MyAvatarCellBuilder(
                    isLoading: !didFinishFetchingAvatars,
                    avatar: .sample,
                    onMenuItemPress: { _ in }
                )
                .padding(.vertical, 11)
            }
        }
    }
    
    private var createNewAvatarButton: some View {
        Button(action: { onCreateAvatarPress?() }) {
            Text("Create Avatar")
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.accent)
                .padding(.horizontal, 8)
                .frame(height: 28)
                .background(.black.opacity(0.0001))
        }
    }
    
    private var avatarDeleteConfirmationDialogActions: some View {
        Group {
            Button("Cancel", role: .cancel, action: {})
            Button("Yes, Delete Avatar", role: .destructive, action: { onYesDeleteAvatarPress() })
        }
    }
}

//MARK: - Actions
///Actions
extension MyAvatarsSectionViewBuilder {
    private func onAvatarMenuActionPress(_ action: MyAvatarCellBuilder.AvatarMenuItem, avatar: AvatarModel) {
        switch action {
        case .edit: print("on edit press")
        case .makePrivate, .makePublic: onUpdateAvatarPrivateFieldPress(avatar)
        case .delete: onDeleteAvatarPress(avatar)
        }
    }
    
    private func onDeleteAvatarPress(_ avatar: AvatarModel) {
        selectedAvatar = avatar
        isShowingDeleteConfirmationDialog.toggle()
    }
    
    private func onYesDeleteAvatarPress() {
        guard let selectedAvatar else { return }
        Task {
            do {
                try await avatarManager.deleteAvatar(selectedAvatar)
            }
            catch {
                print("Error with deleting avatar: \(error)")
            }
        }
    }
    
    private func onUpdateAvatarPrivateFieldPress(_ avatar: AvatarModel) {
        Task {
            do {
                try await avatarManager.updatePrivateField(for: avatar.id, with: !avatar.isPrivate)
            }
            catch {
                print("Error with updating the privacy for avatar: \(error)")
            }
        }
    }
}

//MARK: - Methods
///Methods
extension MyAvatarsSectionViewBuilder {
    private func getMyAvatars() {
        if isPreview { return }
        
        Task {
            do {
                try await avatarManager.updateCurrentUserAvatars(for: try authManager.getId())
            }
            catch {
                print("Error with fetching my avatars: \(error)")
            }
            didFinishFetchingAvatars = true
        }
    }
}

//MARK: Previews
#Preview("previews") {
    NavigationStack {
        ScrollView {
            VStack(spacing: 16) {
                MyAvatarsSectionViewBuilder(
                    avatars: [],
                    didFinishFetchingAvatars: false
                )
                
                MyAvatarsSectionViewBuilder(
                    avatars: [],
                    didFinishFetchingAvatars: true
                )
                
                MyAvatarsSectionViewBuilder(
                    avatars: AvatarModel.samples,
                    didFinishFetchingAvatars: true
                )
                
            }
            .padding(.horizontal)
        }
        .environment(AvatarManager(service: MockAvatarService()))
        .environment(AuthManager(service: MockAuthService(user: .sample())))
    }
}

#Preview("on_run_time") {
    NavigationStack {
        ScrollView {
            VStack(spacing: 16) {
                MyAvatarsSectionViewBuilder()
            }
            .padding(.horizontal)
        }
        .environment(AvatarManager(service: MockAvatarService()))
        .environment(AuthManager(service: MockAuthService(user: .sample())))
    }
}
