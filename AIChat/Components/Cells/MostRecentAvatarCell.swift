//
//  MostRecentAvatarCell.swift
//  AIChat
//
//  Created by Nando on 2/12/25.
//

import SwiftUI

struct MostRecentAvatarCell: View {
    var imageUrlString: String?
    var imageAspectRatio: CGFloat?
    var title: String = "Fernando"
    var isLoading: Bool = true
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {

                if isLoading {
                    Rectangle()
                        .fill(.quinary)
                }
                else {
                    ImageLoaderView(urlString: imageUrlString)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.circle)
            
            
            Text(isLoading ? "xxxx-xxxx" : title)
                .font(.footnote)
                .fontWeight(.semibold)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .redacted(reason: isLoading ? .placeholder : [])
        }
    }
}

#Preview {
    VStack {
        HStack {
            MostRecentAvatarCell()
            MostRecentAvatarCell()
            MostRecentAvatarCell()
            MostRecentAvatarCell()
        }
        .padding(.horizontal)
        
        HStack {
            MostRecentAvatarCell(imageUrlString: Constants.randomImageUrlString, isLoading: false)
            MostRecentAvatarCell(imageUrlString: Constants.randomImageUrlString, isLoading: false)
            MostRecentAvatarCell(imageUrlString: Constants.randomImageUrlString, isLoading: false)
            MostRecentAvatarCell(imageUrlString: Constants.randomImageUrlString, isLoading: false)
        }
        .padding(.horizontal)
    }
   
}
