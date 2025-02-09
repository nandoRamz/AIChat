//
//  ExploreView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ExploreView: View {
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var avatars = AvatarModel.samples
    @State private var featureAvatars: [AvatarModel] = []
    @State private var isLoadingFeaturedAvatars: Bool = true
    @State private var isLoadingAvatarCategories: Bool = true
    @State private var avatarCategories: [CharacterOption] = []
    @State private var popularAvatars: [AvatarModel] = []
    @State private var isLoadingPopularAvatars: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    featureAvatarsView
                    
                    categoriesView
                    
                    popularView
                }
                .padding(.vertical)
            }
            .task { await getFeatureAvatars() }
            .task { await getAvatarCategories() }
            .task { await getPopularAvatars() }
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
 
        do {
            try await Task.sleep(for: .seconds(2))
            avatarCategories = CharacterOption.allCases
        }
        catch {
            print("Error with fetching popular avatars. \(error)")
        }
        isLoadingAvatarCategories = false
    }
}

#Preview {
    ExploreView()
        .environment(AvatarManager(service: MockAvatarService()))
}
