//
//  AvatarCategoriesSectionViewBuilder.swift
//  AIChat
//
//  Created by Nando on 2/9/25.
//

import SwiftUI

struct AvatarCategoriesSectionViewBuilder: View {
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var categories: [CharacterOption] = []
    @State private var didFinishFetchingCategories: Bool = false
    @State private var itemSize: CGSize = .zero
    
    private var isPreview: Bool = false
    ///Only use for Xcode previews
    init(
        categories: [CharacterOption],
        didFinishFetchingCategories: Bool,
        itemsDisplaying: Int,
        itemSize: CGSize = CGSize(width: 0, height: 200)
    ) {
        _categories = State(wrappedValue: categories)
        _didFinishFetchingCategories = State(wrappedValue: didFinishFetchingCategories)
        _itemSize = State(wrappedValue: itemSize)
        self.itemsDisplaying = itemsDisplaying
        self.isPreview = true
    }
    
    var itemsDisplaying: Int
    init(
        itemsDisplaying: Int = 3
    ) {
        self.itemsDisplaying = itemsDisplaying
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Categories")
            
            if !didFinishFetchingCategories {
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
                        numberOfItemsOnScreen: itemsDisplaying,
                        itemsSpacing: 8,
                        scrollTargetBehavior: .viewAligned(limitBehavior: .never),
                        isShowingPageIndicator: false,
                        content: { item in
                            CategoryCell(
                                title: item.rawValue.capitalized,
                                imageName: Constants.randomImageUrlString,
                                isLoading: !didFinishFetchingCategories,
                                cornerRadius: 15
                            )
                        }
                    )
                }
            }
        }
        .onAppear {
            if didFinishFetchingCategories { return }

            getCategories()
        }
    }
}

//MARK: - Methods
///Methods
extension AvatarCategoriesSectionViewBuilder {
    private func getCategories() {
        if isPreview { return }
        //TODO: Do the fetch here and handle error here
        Task {
            try await Task.sleep(for: .seconds(3))
            categories = CharacterOption.allCases
            didFinishFetchingCategories = true
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
                    .containerRelativeFrame(.horizontal, count: itemsDisplaying, spacing: 8)
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
#Preview("previews") {
    ScrollView {
        VStack(spacing: 16) {
            AvatarCategoriesSectionViewBuilder(
                categories: [],
                didFinishFetchingCategories: false,
                itemsDisplaying: 3
            )
            
            AvatarCategoriesSectionViewBuilder(
                categories: [],
                didFinishFetchingCategories: true,
                itemsDisplaying: 3
            )
            
            AvatarCategoriesSectionViewBuilder(
                categories: CharacterOption.allCases,
                didFinishFetchingCategories: true,
                itemsDisplaying: 3
            )
        }
    }
    .contentMargins(.horizontal, 16)
    .environment(AvatarManager(service: MockAvatarService()))
}

#Preview("on_run_time") {
    ScrollView {
        VStack(spacing: 16) {
            AvatarCategoriesSectionViewBuilder()
        }
    }
    .contentMargins(.horizontal, 16)
    .environment(AvatarManager(service: MockAvatarService()))
}
