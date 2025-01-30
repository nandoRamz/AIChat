//
//  ProfileView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var isShowingSettings: Bool = false
    @State private var currentUser: UserModel? = .sample
    @State private var myAvatars: [AvatarModel] = []
    @State private var isLoadingMyAvatars: Bool = true
    @State private var isShowingAvatarConfirmationDialog: Bool = false
    @State private var selectedAvatar: AvatarModel?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    Circle()
                        .fill(currentUser?.getProfileColor() ?? .accentColor)
                        .frame(width: 100, height: 100)
                    
                    myAvatarsSectionView
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .contentMargins(.horizontal, 16)
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
            .navigationDestination(isPresented: $isShowingSettings) {
                SettingsView()
            }
            .task {
                await fetchMyAvatars()
            }
            .confirmationDialog(
                "",
                isPresented: $isShowingAvatarConfirmationDialog,
                titleVisibility: .hidden,
                presenting: selectedAvatar,
                actions: { _ in
                    avatarDeleteActions
                },
                message: { _ in
                    Text("Are you sure you would like to delete this avatar?")
                }
            )
        }
    }
}

//MARK: - Views
///Views
extension ProfileView {
    private var settingsButton: some View {
        Button(action: { onSettingsPress() }) {
            Image(systemName: "gear")
        }
    }
    
    private var avatarDeleteActions: some View {
        Group {
            Button("Cancel", role: .cancel, action: {})
            Button("Yes, Delete Avatar", role: .destructive, action: { onYesDeleteAvatarPress() })
        }
    }
    
    private var myAvatarsSectionView: some View {
        VStack(spacing: 8) {
            HStack {
                ListTitleView(text: "My Avatars")

                Text("Add")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.accent, in: .capsule)
            }
            .padding(.horizontal)
            
            if isLoadingMyAvatars { ProgressView().padding(.all) }
            else {
                if myAvatars.isEmpty {
                    Text("You currently have no avatars.")
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity)
                        .background()
                        .clipShape(.rect(cornerRadius: 15))
                }
                else {
                    LazyVStack(spacing: 0) {
                        ForEach(myAvatars, id: \.self) { avatar in
                            PopularCell(
                                imageUrlString: avatar.profileImageName,
                                title: avatar.name,
                                subTitle: nil
                            )
                            .listStyle(for: avatar, in: myAvatars)
                            .overlay(alignment: .trailing) {
                                Menu {
                                    Button(
                                        "Edit",
                                        systemImage: "eyes",
                                        action: { }
                                    )
                                    
                                    Button(
                                        "Delete",
                                        systemImage: "trash",
                                        role: .destructive,
                                        action: { onDeleteAvatarPress(avatar) }
                                    )
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .fontWeight(.semibold)
                                        .frame(width: 28, height: 28)
                                        .tint(.primary)
                                        .background(.primary.opacity(0.0001))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background()
                    .clipShape(.rect(cornerRadius: 15))
                }
            }
        }
    }
}

//MARK: - Actions
///Actions
extension ProfileView {
    private func onSettingsPress() { isShowingSettings.toggle() }
    
    private func onDeleteAvatarPress(_ avatar: AvatarModel) {
        selectedAvatar = avatar
        isShowingAvatarConfirmationDialog.toggle()
    }
    
    private func onYesDeleteAvatarPress() {
        guard let selectedAvatar else { return }
        if let index = myAvatars.firstIndex(where: {$0 == selectedAvatar}) {
            myAvatars.remove(at: index)
        }
    }
}

//MARK: - Methods
///Methods
extension ProfileView {
    private func fetchMyAvatars() async {
        try? await Task.sleep(for: .seconds(3))
        self.myAvatars = AvatarModel.samples
//        self.myAvatars = []
        isLoadingMyAvatars = false
    }
}

#Preview {
    ProfileView()
}
