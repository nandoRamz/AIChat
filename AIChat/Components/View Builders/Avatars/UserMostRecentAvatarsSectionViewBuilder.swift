//
//  UserMostRecentAvatarsSectionViewBuilder.swift
//  AIChat
//
//  Created by Nando on 2/12/25.
//

import SwiftUI

struct UserMostRecentAvatarsSectionViewBuilder: View {
    @Environment(UserManager.self) private var userManager
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var avatars: [AvatarModel] = []
    @State private var didFinishLoadingMostRecentAvatars: Bool = false
    @State private var itemSize: CGSize = .zero
    
    private var isPreview: Bool = false
    ///Use only for Xcode previews
    init(
        avatars: [AvatarModel],
        didFinishLoadingMostRecentAvatars: Bool
    ) {
        _avatars = State(wrappedValue: avatars)
        _didFinishLoadingMostRecentAvatars = State(wrappedValue: didFinishLoadingMostRecentAvatars)
        self.isPreview = true
    }
    
    var itemsDisplaying: Int = 4
    var onAvatarPress: ((AvatarModel) -> Void)?
    init(onAvatarPress: ((AvatarModel) -> Void)? = nil){
        self.onAvatarPress = onAvatarPress
    }
    
    var body: some View {
        ZStack {
            if !didFinishLoadingMostRecentAvatars {
                loadingView
            }
            else {
                if avatars.isEmpty {
                    NoResultsView(
                        message: "You will be able to see you're recent avatars here.",
                        height: isPreview ? 150 : itemSize.height
                    )
                }
                else {
                    CarouselView(
                        items: avatars,
                        numberOfItemsOnScreen: itemsDisplaying,
                        itemsSpacing: 8,
                        scrollTargetBehavior: .viewAligned(limitBehavior: .never),
                        isShowingPageIndicator: false,
                        content: { avatar in
                            MostRecentAvatarCell(
                                imageUrlString: avatar.imageUrl,
                                imageAspectRatio: 1,
                                title: avatar.name ?? "Unvailable",
                                isLoading: !didFinishLoadingMostRecentAvatars
                            )
                            .background(.primary.opacity(0.0001))
                            .onTapGesture { onAvatarPress?(avatar) }
                        }
                    )
                }
            }
        }
        .task { getAvatars() }
        .animation(.easeInOut, value: avatars)
    }
}

//MARK: - Views
///Views
extension UserMostRecentAvatarsSectionViewBuilder {
    private var loadingView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(0..<(itemsDisplaying + 1), id: \.self) { _ in
                    MostRecentAvatarCell(
                        imageUrlString: "",
                        imageAspectRatio: 1,
                        title: "",
                        isLoading: true
                    )
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 8)
                    .getSize($itemSize)
                }
            }
        }
        .scrollClipDisabled(true)
        .disabled(true)
    }
}

//MARK: - Methods
///Methods
extension UserMostRecentAvatarsSectionViewBuilder {
    private func getAvatars() {
        if isPreview { return }
        Task {
            do {
                let mostRecentAvatars = try await userManager.getMostRecentAvatars(for: try authManager.getId())
                let ids = mostRecentAvatars.map { $0.avatarId }
                let fetchedAvatars = try await avatarManager.getAvatars(with: ids)
                avatars = avatarManager.orderMostRecentAvatars(
                    mostRecentAvatars,
                    using: fetchedAvatars
                )
            }
            catch {
                print("Error with fetching most recent avatars: \(error)")
            }
            didFinishLoadingMostRecentAvatars = true
        }
    }
}

//MARK: - Previews
#Preview("preview") {
    ScrollView {
        VStack(spacing: 16) {
            UserMostRecentAvatarsSectionViewBuilder(
                avatars: [],
                didFinishLoadingMostRecentAvatars: false
            )
            
            UserMostRecentAvatarsSectionViewBuilder(
                avatars: [],
                didFinishLoadingMostRecentAvatars: true
            )
            
            UserMostRecentAvatarsSectionViewBuilder(
                avatars: AvatarModel.samples,
                didFinishLoadingMostRecentAvatars: true
            )
        }
        .padding(.horizontal)
    }
    
    .environment(UserManager(service: MockUserService()))
    .environment(AuthManager(service: MockAuthService(user: .sample())))
    .environment(AvatarManager(service: MockAvatarService()))
}

#Preview("on_run_time") {
    ScrollView {
        VStack(spacing: 16) {
            UserMostRecentAvatarsSectionViewBuilder()
        }
        .padding(.horizontal)
    }
    .environment(UserManager(service: MockUserService()))
    .environment(AuthManager(service: MockAuthService(user: .sample())))
    .environment(AvatarManager(service: MockAvatarService()))
}
