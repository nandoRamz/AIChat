//
//  PopularAvatarSectionViewBuilder.swift
//  AIChat
//
//  Created by Nando on 2/9/25.
//

import SwiftUI

struct PopularAvatarSectionViewBuilder: View {
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var cardSize: CGSize = .zero
    @State private var avatars: [AvatarModel] = []
    @State private var didFinishFetchingAvatars: Bool = false
    private var isPreview: Bool = false
    
    var maxAvatars: Int = 5
    
    ///Use only for Xcode Preview
    init(avatars: [AvatarModel], didFinishFetchingAvatars: Bool) {
        _avatars = State(wrappedValue: avatars)
        _didFinishFetchingAvatars = State(wrappedValue: didFinishFetchingAvatars)
        self.isPreview = true
    }
    
    init(maxAvatars: Int = 5) {
        self.maxAvatars = maxAvatars
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Popular")
            
            ZStack {
                if !didFinishFetchingAvatars {
                    loadingView
                        .getSize($cardSize)
                }
                else {
                    if avatars.isEmpty {
                        NoResultsView(
                            message: "We couldn't find any popular avatars. Please try again later.",
                            height: cardSize.height
                        )
                    }
                    else {
                        avatarsView
                    }
                }
            }
        }
        .onAppear {
            if didFinishFetchingAvatars { return }
            getAvatars()
        }
    }
}

//MARK: - Views
///Views
extension PopularAvatarSectionViewBuilder {
    private var avatarsView: some View {
        VStack(spacing: 0) {
            ForEach(avatars.prefix(maxAvatars), id: \.self) { avatar in
                PopularCell(
                    imageUrlString: avatar.imageUrl,
                    title: avatar.name,
                    subTitle: avatar.characterDescription()
                )
                .padding(.vertical, 11)
            }
            
            if avatars.count < maxAvatars {
                ForEach(0..<(maxAvatars - avatars.count), id: \.self) { _ in
                    redactedPopularCellView
                        .padding(.vertical)
                        .opacity(0)
                }
            }
        }
        .padding(.vertical, 11)
        .padding(.horizontal)
        .background(isDarkMode ? .ultraThinMaterial : .bar)
        .clipShape(.rect(cornerRadius: 15))
    }
    
    private var loadingView: some View {
        VStack(spacing: 0) {
            ForEach(0..<maxAvatars, id: \.self) { _ in
                redactedPopularCellView
                    .padding(.vertical, 11)
            }
        }
        .padding(.vertical, 11)
        .padding(.horizontal)
        .background(isDarkMode ? .ultraThinMaterial : .bar)
        .clipShape(.rect(cornerRadius: 15))
    }
    
    private var redactedPopularCellView: some View {
        PopularCell(
            imageUrlString: "",
            title: "",
            subTitle: "",
            isLoading: true
        )
    }
}

//MARK: - Methods
///Methods
extension PopularAvatarSectionViewBuilder {
    private func getAvatars() {
        if isPreview { return }
        Task {
            do {
                avatars = try await avatarManager.getPopularAvatars()
            }
            catch {
                print("Error we couldn't fetch popular avatars: \(error)")
            }
            didFinishFetchingAvatars = true
        }
    }
}

//MARK: - Previews
#Preview {
    ScrollView {
        VStack(spacing: 16) {
//            PopularAvatarSectionViewBuilder()
//            PopularAvatarSectionViewBuilder(previewState: .loading)
//            PopularAvatarSectionViewBuilder(previewState: .noResults)
//            PopularAvatarSectionViewBuilder(previewState: .doneLoading)
        }
        .padding(.horizontal)
    }
    .environment(AvatarManager(service: MockAvatarService()))
}
