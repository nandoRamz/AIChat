//
//  ExploreView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ExploreView: View {
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var navManager = NavigationManager()

    @State private var isLoadingAvatarCategories: Bool = true
    @State private var avatarCategories: [CharacterOption] = []
    @State private var popularAvatars: [AvatarModel] = []
    @State private var isLoadingPopularAvatars: Bool = true
    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            ScrollView {
                VStack(spacing: 32) {
                    FeatureAvatarsSectionViewBuilder()
                    
                    AvatarCategoriesSectionViewBuilder()
                    
                    PopularAvatarSectionViewBuilder(
                        maxAvatars: 5,
                        onAvatarPress: { avatar in
                            navManager.path.append(avatar)
                        }
                    )
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
            .background(Color(uiColor: .systemGroupedBackground)) //Change this later
            .contentMargins(.horizontal, 16)
            .navigationTitle("Explore")
            .navigationDestination(for: AvatarModel.self) { value in
                ChatMessageListView(avatar: value)
            }
        }
    }
}


#Preview {
    ExploreView()
        .environment(UserManager(service: MockUserService()))
        .environment(AuthManager(service: MockAuthService(user: .sample())))
        .environment(AvatarManager(service: MockAvatarService()))
}
