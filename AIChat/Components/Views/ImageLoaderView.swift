//
//  ImageLoaderView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var urlString: String? = Constants.randomImageUrlString
    var contentMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .fill(.quinary)
            .overlay {
                if let urlString {
                    WebImage(url: URL(string: urlString))
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(contentMode: contentMode)
                        .allowsHitTesting(false)
                }                    
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .frame(width: 300, height: 300)
}
