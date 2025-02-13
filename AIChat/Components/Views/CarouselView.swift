//
//  CarouselView.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct CarouselView<T: Hashable, Content: View, ScrollBehavior: ScrollTargetBehavior>: View {
    @State private var selectedItem: T?

    var items: [T]
    var numberOfItemsOnScreen: Int = 1
    var itemsSpacing: CGFloat = 8
    var scrollTargetBehavior: ScrollBehavior
    var isShowingPageIndicator: Bool = true
    @ViewBuilder var content: (T) -> Content
    
    var body: some View {
        VStack(spacing: 16) {
            itemsScrollView
        }
        .onAppear { updateSelection() }
        .onChange(of: items) { _, _ in
            updateSelection()
        }
    }
}

//MARK: - Views
///Views
extension CarouselView {
    private var itemsScrollView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: itemsSpacing) {
                ForEach(items, id: \.self) { item in
                    content(item)
                        .id(item)
                        .containerRelativeFrame(.horizontal, count: numberOfItemsOnScreen, spacing: itemsSpacing)
                }
            }
            .scrollTargetLayout()
        }
        .scrollClipDisabled(true)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(scrollTargetBehavior)
        .scrollPosition(id: $selectedItem)
    }
}

//MARK: - Methods
///Methods
extension CarouselView {
    private func updateSelection() {
//        withAnimation(.easeInOut) {
            selectedItem = items.first
//        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 32) {
            CarouselView(
                items: AvatarModel.samples,
                scrollTargetBehavior: .viewAligned, 
                content: { item in
                    FeatureCell(
                        title: item.name ?? "",
                        subTitle: item.characterDescription(),
                        imageName: item.imageUrl
                    )
                }
            )
            
            CarouselView(
                items: CharacterAction.allCases,
                numberOfItemsOnScreen: 3,
                scrollTargetBehavior: .viewAligned(limitBehavior: .never),
                isShowingPageIndicator: false,
                content: { item in
                    CategoryCell(
                        title: item.rawValue,
                        imageName: Constants.randomImageUrlString
                    )
                }
            )
        }
        
    }
    .contentMargins(.horizontal, 16)
}
