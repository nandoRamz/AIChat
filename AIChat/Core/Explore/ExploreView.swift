//
//  ExploreView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ExploreView: View {
    @Environment(AvatarManager.self) private var avatarManager

    @State private var isLoadingAvatarCategories: Bool = true
    @State private var avatarCategories: [CharacterOption] = []
    @State private var popularAvatars: [AvatarModel] = []
    @State private var isLoadingPopularAvatars: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    FeatureAvatarsSectionViewBuilder()
                    
                    AvatarCategoriesSectionViewBuilder()
                    
                    PopularAvatarSectionViewBuilder()
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
            .background(Color(uiColor: .systemGroupedBackground)) //Change this later
            .contentMargins(.horizontal, 16)
            .navigationTitle("Explore")
        }
    }
}


#Preview {
    ExploreView()
        .environment(AvatarManager(service: MockAvatarService()))
}
