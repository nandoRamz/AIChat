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
    var isLoading: Bool = true
    var cornerRadius: CGFloat = 15
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isLoading {
                Rectangle()
                    .fill(.quinary)
                
                titleView
                    .foregroundStyle(.secondary)
            }
            else {
                ImageLoaderView(urlString: imageName)
                
                titleView
                    .foregroundStyle(.white)
                    .imageTextGradientStyle()
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(.rect(cornerRadius: cornerRadius))
    }
}

//MARK: - Views
///Views
extension CategoryCell {
    var titleView: some View {
        Text(isLoading ? "xxxx_xxxx_xxxx_xxxx" : title)
            .lineLimit(isLoading ? 1 : nil)
            .font(font)
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .redacted(reason: isLoading ? .placeholder : [])
    }
}

#Preview("loading") {
    CategoryCell()
        .frame(width: 200)
}

#Preview("done_loading") {
    CategoryCell(isLoading: false)
        .frame(width: 200)
}

#Preview("done_loading_with_long_title") {
    CategoryCell(title: "This is some really long title. Here is some more text.", isLoading: false)
        .frame(width: 200)
}
