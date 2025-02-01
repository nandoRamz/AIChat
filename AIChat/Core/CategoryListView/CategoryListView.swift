//
//  CategoryListView.swift
//  AIChat
//
//  Created by Nando on 2/1/25.
//

import SwiftUI

struct CategoryListView: View {
    @State private var avatars: [AvatarModel] = AvatarModel.samples
    
    var category: CharacterOption = .alien
    var imageNamge: String = Constants.randomImageUrlString

    var body: some View {
        ScrollView {
            CategoryCell(
                title: category.rawValue.capitalized,
                imageName: imageNamge,
                font: .largeTitle,
                cornerRadius: 0
            )
           
            LazyVStack(spacing: 0) {
                ForEach(avatars, id: \.self) { avatar in
                    PopularCell(
                        imageUrlString: avatar.profileImageName,
                        title: avatar.name,
                        subTitle: avatar.characterDescription()
                    )
                    .listStyle(for: avatar, in: avatars)
                }
            }
            .padding(.horizontal)
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        CategoryListView()

    }
}
