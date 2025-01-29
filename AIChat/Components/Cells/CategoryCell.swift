//
//  CategoryCell.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct CategoryCell: View {
    var title: String = "Aliens"
    var imageName: String = Constants.randomImageUrlString
    var font: Font = .title2
    var cornerRadius: CGFloat = 15
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
                
            Text(title)
                .font(font)
                .fontWeight(.semibold)
                .padding()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .imageTextGradientStyle()
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(.rect(cornerRadius: cornerRadius))
    }
}

#Preview {
    CategoryCell()
        .frame(width: 200)
}
