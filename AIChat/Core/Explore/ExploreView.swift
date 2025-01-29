//
//  ExploreView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct ExploreView: View {
    let avatar = AvatarModel.sample
    
    var body: some View {
        NavigationStack {
            HeroCell(
                title: avatar.name,
                subTitle: avatar.characterDescription(),
                imageName: avatar.profileImageName
            )
            .frame(height: 200)
            .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}
