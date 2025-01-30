//
//  ChatCell.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import SwiftUI

struct ChatCell: View {
    var imageUrlString: String? = Constants.randomImageUrlString
    var title: String = "Alpha"
    var subTitle: String = "This is the latest message"
    var isShowingBadge: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(.quinary)
                
                if let imageUrlString {
                    ImageLoaderView(urlString: imageUrlString)
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                Text(subTitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if isShowingBadge {
                Text("New")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.accent)
                    .clipShape(.capsule)
            }
        }
    }
}

#Preview {
    VStack {
        ChatCell()
            .padding(.horizontal)
        
        ChatCell(isShowingBadge: true)
            .padding(.horizontal)
    }
}
