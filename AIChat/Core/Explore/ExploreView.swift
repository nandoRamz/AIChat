//
//  ExploreView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ExploreView: View {
    @State private var avatars = AvatarModel.samples
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    featureAvatarsView
                    
                    categoriesView
                    
                    popularView
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(uiColor: .systemGroupedBackground)) //Change this later
            .contentMargins(.horizontal, 16)
            .navigationTitle("Explore")
        }
    }
}

//MARK: - Views
///Views
extension ExploreView {
    private var popularView: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Popular")
                .padding(.horizontal, 16)
            
            LazyVStack(spacing: 0) {
                ForEach(avatars, id: \.self) { avatar in
                    PopularCell(
                        imageUrlString: avatar.profileImageName,
                        title: avatar.name,
                        subTitle: avatar.characterDescription()
                    )
                    .padding(.vertical, 11)
                    .background(
                        Divider()
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding(.horizontal, -16)
                            .opacity(avatar == avatars.last ? 0 : 1)
                    )
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 11)
            .background()
            .clipShape(.rect(cornerRadius: 15))
        }
    }
    
    private var categoriesView: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Categories")
                .padding(.horizontal, 16)
            
            CarouselView(
                items: CharacterOption.allCases,
                numberOfItemsOnScreen: 3,
                scrollTargetBehavior: .viewAligned(limitBehavior: .never),
                isShowingPageIndicator: false,
                content: { item in
                    CategoryCell(
                        title: item.rawValue.capitalized,
                        imageName: Constants.randomImageUrlString
                    )
                }
            )
        }
    }
    
    private var featureAvatarsView: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Featured Avatars")
                .padding(.horizontal, 16)
            
            CarouselView(
                items: avatars,
                scrollTargetBehavior: .viewAligned,
                content: { item in
                    HeroCell(
                        title: item.name,
                        subTitle: item.characterDescription(),
                        imageName: item.profileImageName
                    )
                    .frame(height: 200)
                }
            )
        }
    }
}

#Preview {
    ExploreView()
}
