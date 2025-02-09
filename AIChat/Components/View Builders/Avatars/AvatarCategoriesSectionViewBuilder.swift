//
//  AvatarCategoriesSectionViewBuilder.swift
//  AIChat
//
//  Created by Nando on 2/9/25.
//

import SwiftUI

struct AvatarCategoriesSectionViewBuilder: View {   
    @State private var itemSize: CGSize = .zero
        
    var categories: [CharacterOption] = []
    var itemsDisplaying: Int = 3
    var isLoading: Bool = true
    
    var body: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Categories") //
            
            if isLoading {
                loadingView
            }
            else {
                if categories.isEmpty {
                    NoResultsView(
                        message: "We couldn't fetch the avatar categories. Please try again later.",
                        height: itemSize.height
                    )
                }
                else {
                    CarouselView(
                        items: categories,
                        numberOfItemsOnScreen: 3,
                        itemsSpacing: 8,
                        scrollTargetBehavior: .viewAligned(limitBehavior: .never),
                        isShowingPageIndicator: false,
                        content: { item in
                            CategoryCell(
                                title: item.rawValue.capitalized,
                                imageName: Constants.randomImageUrlString,
                                isLoading: isLoading,
                                cornerRadius: 15
                            )
                        }
                    )
                }
            }
        }
    }
}

//MARK: - Views
///Views
extension AvatarCategoriesSectionViewBuilder {
    private var loadingView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(0..<(itemsDisplaying + 1), id: \.self) { x in
                    CategoryCell(
                        title: "",
                        imageName: "",
                        isLoading: true,
                        cornerRadius: 15
                    )
                    .containerRelativeFrame(.horizontal, count: 3, spacing: 8)
                    .getSize($itemSize)
                }
            }
        }
        .frame(height: itemSize.width)
        .scrollClipDisabled()
        .disabled(true)
    }
}


//MARK: - Previews
#Preview("loading") {
    ZStack {
        Color.black.opacity(0.1)
        
        AvatarCategoriesSectionViewBuilder(
            categories: [],
            itemsDisplaying: 3,
            isLoading: true
        )
        .padding(.horizontal)
    }
}

#Preview("done_loading") {
    ZStack {
        Color.black.opacity(0.1)
        
        AvatarCategoriesSectionViewBuilder(
            categories: CharacterOption.allCases,
            itemsDisplaying: 3,
            isLoading: false
        )
        .padding(.horizontal)
    }
}

fileprivate struct NoDataPreview: View {
    @State private var isLoading: Bool = true
    var body: some View {
        ZStack {
            Color.black.opacity(0.1)
            
            AvatarCategoriesSectionViewBuilder(
                categories: [],
                itemsDisplaying: 3,
                isLoading: isLoading
            )
            .padding(.horizontal)
        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            isLoading = false
        }
    }
}
#Preview("done_loading_with_no_data") {
    NoDataPreview()
}
