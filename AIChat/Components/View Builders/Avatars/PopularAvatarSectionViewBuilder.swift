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
    
    @State private var cardSize: CGSize = .zero
    
    var maxAvatars: Int = 5
    var avatars: [AvatarModel] = []
    var isLoading: Bool = true
    
    var body: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Popular")
            
            ZStack {
                if isLoading {
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
        }
        .padding(.vertical, 11)
        .padding(.horizontal)
        .background(isDarkMode ? .ultraThinMaterial : .bar)
        .clipShape(.rect(cornerRadius: 15))
    }
    
    private var loadingView: some View {
        VStack(spacing: 0) {
            ForEach(0..<maxAvatars, id: \.self) { _ in
                PopularCell(
                    imageUrlString: "",
                    title: "",
                    subTitle: "",
                    isLoading: true
                )
                .padding(.vertical, 11)
            }
        }
        .padding(.vertical, 11)
        .padding(.horizontal)
        .background(isDarkMode ? .ultraThinMaterial : .bar)
        .clipShape(.rect(cornerRadius: 15))
    }
}


//MARK: - Previews
#Preview("loading") {
    ZStack {
        Color.black.opacity(0.2)
        
        PopularAvatarSectionViewBuilder(
            maxAvatars: 5,
            avatars: AvatarModel.samples,
            isLoading: true
        )
        .padding(.horizontal)
    }
}

#Preview("done_loading_less_data") {
    ZStack {
        Color.black.opacity(0.2)
        
        PopularAvatarSectionViewBuilder(
            maxAvatars: 7,
            avatars: AvatarModel.samples,
            isLoading: false
        )
        .padding(.horizontal)
    }
}

#Preview("done_loading_more_data") {
    ZStack {
        Color.black.opacity(0.2)
        
        PopularAvatarSectionViewBuilder(
            maxAvatars: 2,
            avatars: AvatarModel.samples,
            isLoading: false
        )
        .padding(.horizontal)
    }
}

fileprivate struct noDataPreview: View {
    @State private var isLoading = true
    @State private var avatars = []
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            
            PopularAvatarSectionViewBuilder(
                maxAvatars: 5,
                avatars: [],
                isLoading: isLoading
            )
            .padding(.horizontal)
        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            isLoading.toggle()
        }
    }
}
#Preview("done_loading_no_data") {
    noDataPreview()
}
