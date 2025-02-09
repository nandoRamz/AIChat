//
//  CarouselSectionView.swift
//  AIChat
//
//  Created by Nando on 2/8/25.
//

import SwiftUI

struct CarouselSectionView<Content: View>: View {
    @State private var carouselSize: CGSize = .zero
    
    var title: String = "Some title"
    var isLoading: Bool = true
    var numberOfItemsOnScreen: Int = 1
    var itemSpacing: CGFloat = 8
    var isEmpty: Bool = false
    var emptyTextMessage: String? = nil
    var contentHeight: CGFloat? = 200
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 8) {
            ListTitleView(text: title)
            
            if isLoading {
                CarouselView(
                    items: AvatarModel.samples,
                    numberOfItemsOnScreen: numberOfItemsOnScreen,
                    itemsSpacing: itemSpacing,
                    scrollTargetBehavior: .viewAligned,
                    isShowingPageIndicator: false,
                    content: { _ in
                        if let contentHeight {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.quinary)
                                .frame(height: contentHeight)
                        }
                        else {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.quinary)
                                .aspectRatio(1, contentMode: .fill)
                        }
                    }
                )
                .getSize($carouselSize)
            }
            else {
                if isEmpty {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Text(emptyTextMessage ?? "There's no entries at this moment please try at a later time.")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal)
                        }
                        .frame(height: carouselSize.height)
                }
                else {
                    content
                        .frame(height: contentHeight)
                }
            }
        }
    }
}



#Preview("loading") {
    NavigationStack {
        ScrollView {
            CarouselSectionView(isLoading: true, content: { EmptyView() })
                .padding(.horizontal)
        }
        .navigationTitle("Explore")
    }
}


// The isEmpty does work but not in preview
#Preview("done_loading_with_data") {
    NavigationStack {
        ScrollView {
            CarouselSectionView(
                isLoading: false,
                isEmpty: false,
                contentHeight: 250,
                content: {
                    CarouselView(
                        items: AvatarModel.samples,
                        numberOfItemsOnScreen: 1,
                        itemsSpacing: 8,
                        scrollTargetBehavior: .viewAligned,
                        isShowingPageIndicator: false,
                        content: { item in
                            FeatureCell(
                                title: item.name ?? "",
                                subTitle: item.characterDescription(),
                                imageName: item.imageUrl
                            )
                        }
                    )
                }
            )
            .padding(.horizontal)
        }
        .navigationTitle("Explore")
    }
}

#Preview("done_loading_no_data") {
    NavigationStack {
        ScrollView {
            CarouselSectionView(isLoading: false, isEmpty: true, content: { EmptyView() })
                .padding(.horizontal)
        }
        .navigationTitle("Explore")
    }
}

#Preview("no_height") {
    NavigationStack {
        ScrollView {
            CarouselSectionView(
                title: "Some Title",
                isLoading: true,
                numberOfItemsOnScreen: 2,
                itemSpacing: 8,
                isEmpty: false,
                emptyTextMessage: nil,
                contentHeight: nil,
                content: {
                    EmptyView()
                }
            )
            
            CarouselSectionView(
                title: "Some Title",
                isLoading: true,
                numberOfItemsOnScreen: 3,
                itemSpacing: 8,
                isEmpty: false,
                emptyTextMessage: nil,
                contentHeight: nil,
                content: {
                    EmptyView()
                }
            )
            
            CarouselSectionView(
                title: "Some Title",
                isLoading: false,
                numberOfItemsOnScreen: 3,
                itemSpacing: 8,
                isEmpty: true,
                emptyTextMessage: nil,
                contentHeight: nil,
                content: {
                    EmptyView()
                }
            )
                
        }
        .contentMargins(.horizontal, 16)
        .navigationTitle("Explore")
    }
}
