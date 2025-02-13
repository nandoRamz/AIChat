//
//  FeatureAvatarsSectionViewBuilder.swift
//  AIChat
//
//  Created by Nando on 2/9/25.
//

import SwiftUI

struct FeatureAvatarsSectionViewBuilder: View {
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var avatars: [AvatarModel] = []
    @State private var didFinishFetchingAvatars: Bool = false
    
    private var isPreview: Bool = false
    ///Only user for Xcode preivews
    init(avatars: [AvatarModel], didFinishFetchingAvatars: Bool, height: CGFloat) {
        _avatars = State(wrappedValue: avatars)
        _didFinishFetchingAvatars = State(wrappedValue: didFinishFetchingAvatars)
        self.height = height
        self.isPreview = true
    }
    
    var height: CGFloat
    init(height: CGFloat = 200) {
        self.height = height
    }
   
    var body: some View {
        VStack(spacing: 8) {
            ListTitleView(text: "Feature") //
            
            if !didFinishFetchingAvatars {
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
                        numberOfItemsOnScreen: 1,
                        itemsSpacing: 8,
                        scrollTargetBehavior: .viewAligned,
                        isShowingPageIndicator: false,
                        content: { item in
                            FeatureCell(
                                title: item.name ?? "",
                                subTitle: item.characterDescription(),
                                imageName: item.imageUrl,
                                isLoading: !didFinishFetchingAvatars
                            )
                        }
                    )
                    .frame(height: height)
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
extension FeatureAvatarsSectionViewBuilder {
    private var loadingView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(0..<2, id: \.self) { x in
                    FeatureCell(
                        title: "",
                        subTitle: "",
                        imageName: Constants.randomImageUrlString,
                        isLoading: true
                    )
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 8)
                }
            }
        }
        .frame(height: height)
        .scrollClipDisabled()
        .disabled(true)
    }
}

//MARK: - Methods
///Methods
extension FeatureAvatarsSectionViewBuilder {
    private func getAvatars() {
        if isPreview { return }
        Task {
            do {
                avatars = try await avatarManager.getFeatureAvatars()
            }
            catch {
               print("Error with fetching avatar categories: \(error)")
            }
            didFinishFetchingAvatars = true
        }
    }
}

#Preview("previews") {
    ScrollView {
        VStack(spacing: 16) {
            FeatureAvatarsSectionViewBuilder(
                avatars: [],
                didFinishFetchingAvatars: false,
                height: 200
            )
            
            FeatureAvatarsSectionViewBuilder(
                avatars: [],
                didFinishFetchingAvatars: true,
                height: 200
            )
            
            FeatureAvatarsSectionViewBuilder(
                avatars: AvatarModel.samples,
                didFinishFetchingAvatars: true,
                height: 200
            )
        }
        .padding(.horizontal)
    }
    .environment(AvatarManager(service: MockAvatarService()))
}

#Preview("on_run_time") {
    ScrollView {
        VStack(spacing: 16) {
            FeatureAvatarsSectionViewBuilder()
        }
        .padding(.horizontal)
    }
    .environment(AvatarManager(service: MockAvatarService()))
}
