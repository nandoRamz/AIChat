//
//  FeatureAvatarsSectionViewBuilder.swift
//  AIChat
//
//  Created by Nando on 2/9/25.
//

import SwiftUI

struct FeatureAvatarsSectionViewBuilder: View {
    @State private var itemSize: CGSize = .zero
        
    var avatars: [AvatarModel] = []
    var itemsDisplaying: Int = 1
    var isLoading: Bool = true
    var height: CGFloat = 200
    
    var body: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Feature") //
            
            if isLoading {
                loadingView
            }
            else {
                if avatars.isEmpty {
                    NoResultsView(
                        message: "We couldn't fetch feature avatars. Please try again later.",
                        height: height
                    )
                }
                else {
                    CarouselView(
                        items: avatars,
                        numberOfItemsOnScreen: itemsDisplaying,
                        itemsSpacing: 8,
                        scrollTargetBehavior: .viewAligned(limitBehavior: .never),
                        isShowingPageIndicator: false,
                        content: { item in
                            FeatureCell(
                                title: item.name ?? "",
                                subTitle: item.characterDescription(),
                                imageName: item.imageUrl,
                                isLoading: isLoading
                            )
                        }
                    )
                    .frame(height: height)
                }
            }
        }
    }
}

//MARK: - Views
///Views
extension FeatureAvatarsSectionViewBuilder {
    private var loadingView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(0..<(itemsDisplaying + 1), id: \.self) { x in
                    FeatureCell(
                        title: "",
                        subTitle: "",
                        imageName: Constants.randomImageUrlString,
                        isLoading: true
                    )
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 8)
                    .getSize($itemSize)
                }
            }
        }
        .frame(height: height)
        .scrollClipDisabled()
        .disabled(true)
    }

}

#Preview() {
    VStack {
        FeatureAvatarsSectionViewBuilder(
            avatars: [],
            itemsDisplaying: 1,
            isLoading: true
        )
        
        FeatureAvatarsSectionViewBuilder(
            avatars: AvatarModel.samples,
            itemsDisplaying: 1,
            isLoading: false
        )
        
        FeatureAvatarsSectionViewBuilder(
            avatars: [],
            itemsDisplaying: 1,
            isLoading: false
        )
    }
    .padding(.horizontal)
}
