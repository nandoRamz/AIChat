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
    
    var itemsDisplaying: Int
    var previewState: PreviewState?
    
    init(
        itemsDisplaying: Int = 3
    ) {
        self.itemsDisplaying = itemsDisplaying
    }
    
    init(
        previewState: PreviewState,
        itemsDisplaying: Int = 3
    ) {
        self.previewState = previewState
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

            setViewState()
        }
    }
}

//MARK: - Methods
///Methods
extension AvatarCategoriesSectionViewBuilder {
    private func getCategories() {
        //TODO: Do the fetch here and handle error here
        Task {
            try await Task.sleep(for: .seconds(3))
            categories = CharacterOption.allCases
            didFinishFetchingCategories = true
        }
    }
    
    private func setViewState() {
        switch previewState {
        case .loading: break
        case .noResults:
            Task {
                try await Task.sleep(for: .seconds(0.3))
                didFinishFetchingCategories = true
            }
        case .doneLoading:
            didFinishFetchingCategories = true
            categories = CharacterOption.allCases
        case .none:
            getCategories()
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
#Preview() {
    ScrollView {
        VStack(spacing: 16) {
            AvatarCategoriesSectionViewBuilder()
            AvatarCategoriesSectionViewBuilder(previewState: .loading)
            AvatarCategoriesSectionViewBuilder(previewState: .noResults)
            AvatarCategoriesSectionViewBuilder(previewState: .doneLoading)
            AvatarCategoriesSectionViewBuilder(itemsDisplaying: 2)
            
        }
    }
    .contentMargins(.horizontal, 16)
    .environment(AvatarManager(service: MockAvatarService()))
}
