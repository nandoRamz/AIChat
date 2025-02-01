//
//  AvatarProfileModal.swift
//  AIChat
//
//  Created by Nando on 2/1/25.
//

import SwiftUI

struct AvatarProfileModal: View {
    var imageUrlString: String? = Constants.randomImageUrlString
    var title: String? = "Some Title"
    var subtitle: String = "Some sub title"
    
    var body: some View {
        VStack {
            ImageLoaderView(urlString: imageUrlString)
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            
            VStack(alignment: .leading) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 15))
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
        
        AvatarProfileModal()
            .padding(.horizontal, 32)
    }
    
}
