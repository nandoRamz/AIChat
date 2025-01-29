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
                }
            }
            .contentMargins(.horizontal, 16)
            .contentMargins(.vertical, 24)
            .navigationTitle("Explore")
        }
    }
}

//MARK: - Views
///Views
extension ExploreView {
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
}

#Preview {
    ExploreView()
}
