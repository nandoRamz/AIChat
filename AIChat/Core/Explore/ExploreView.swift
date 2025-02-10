//
//  ExploreView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ExploreView: View {
    @Environment(AvatarManager.self) private var avatarManager
    @State private var secondsLoading = 0
    private var isShowingScreen: Bool {
        !isLoadingPopularAvatars && !isLoadingFeaturedAvatars && !isLoadingAvatarCategories
    }
    
    @State private var avatars = AvatarModel.samples
    @State private var featureAvatars: [AvatarModel] = []
    @State private var isLoadingFeaturedAvatars: Bool = true
    @State private var isLoadingAvatarCategories: Bool = true
    @State private var avatarCategories: [CharacterOption] = []
    @State private var popularAvatars: [AvatarModel] = []
    @State private var isLoadingPopularAvatars: Bool = true
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isShowingScreen {
                    ScrollView {
                        VStack(spacing: 32) {
                            featureAvatarsView
                            
                            categoriesView
                            
                            popularView
                        }
                        .padding(.vertical)
                    }
                    .scrollIndicators(.hidden)
                    .background(Color(uiColor: .systemGroupedBackground)) //Change this later
                    .contentMargins(.horizontal, 16)
                }
                else {
                    if secondsLoading == 2 {
                        VStack(spacing: 8) {
                            ProgressView()
                            
                            Text("Loading")
                                .foregroundStyle(.secondary)
                            
                        }
                        .background(.clear)
                    }
                }
            }
            .task {
                while secondsLoading < 2 {
                    try? await Task.sleep(for: .seconds(1))
                    secondsLoading += 1
                }
            }
            .task { await getFeatureAvatars() }
            .task { await getAvatarCategories() }
            .task { await getPopularAvatars() }
            .animation(.easeInOut, value: isShowingScreen)
            .navigationTitle("Explore")
        }
    }
}

//MARK: - Views
///Views
extension ExploreView {
    private var popularView: some View {
        PopularAvatarSectionViewBuilder(
            maxAvatars: 5,
            avatars: popularAvatars,
            isLoading: isLoadingPopularAvatars
        )
    }
    
    private var categoriesView: some View {
        AvatarCategoriesSectionViewBuilder(
            categories: avatarCategories,
            itemsDisplaying: 3,
            isLoading: isLoadingAvatarCategories
        )
    }
    
    private var featureAvatarsView: some View {
        FeatureAvatarsSectionViewBuilder(
            avatars: featureAvatars,
            itemsDisplaying: 1,
            isLoading: isLoadingFeaturedAvatars,
            height: 200
        )
    }
}

//MARK: - Methods
///Methods
extension ExploreView {
    private func getFeatureAvatars() async {
        if !isLoadingFeaturedAvatars { return }
        
        do {
            featureAvatars = try await avatarManager.getFeatureAvatars()
        }
        catch {
            print("Error with fetching feature avatars. \(error)")
        }
        isLoadingFeaturedAvatars = false
    }
    
    private func getPopularAvatars() async {
        if !isLoadingPopularAvatars { return }

        do {
            popularAvatars = try await avatarManager.getPopularAvatars()
        }
        catch {
            print("Error with fetching popular avatars. \(error)")
        }
        isLoadingPopularAvatars = false
    }
    
    private func getAvatarCategories() async {
        if !isLoadingAvatarCategories { return }
 
//        do {
//            try await Task.sleep(for: .seconds(1))
//            avatarCategories = CharacterOption.allCases
//        }
//        catch {
//            print("Error with fetching popular avatars. \(error)")
//        }
        
        avatarCategories = CharacterOption.allCases
        isLoadingAvatarCategories = false
    }
}

#Preview {
    ExploreView()
        .environment(AvatarManager(service: MockAvatarService()))
}
