//
//  PopularCell.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct PopularCell: View {
    var imageUrlString: String? = Constants.randomImageUrlString
    var title: String? = "Some Title"
    var subTitle: String? = "Some Sub Title"
    var isLoading: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            imageView
            
            infoView
        }
    }
}

//MARK: - Views
///Views
extension PopularCell {
    private var infoView: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(isLoading ? "xxxx-xxxx-xxxx" : title)
                    .font(.headline)
                    .redacted(reason: isLoading ? .placeholder : [])
            }
            
            if let subTitle {
                Text(isLoading ? "xxxx-xxxx-xxxx-xxxx-xxxx" : subTitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .redacted(reason: isLoading ? .placeholder : [])
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var imageView: some View {
        ZStack {
            if isLoading {
                Rectangle()
                    .fill(.quinary)
            }
            else {
                if let imageUrlString {
                    ImageLoaderView(urlString: imageUrlString)
                    
                }
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    ZStack {
        Color(uiColor: .systemGroupedBackground)
            .ignoresSafeArea()
        
        VStack {
            PopularCell()
                .padding(.all)
                .background()
                .padding(.horizontal)
            
            PopularCell(isLoading: false)
                .padding(.all)
                .background()
                .padding(.horizontal)
            
            PopularCell()
                .padding(.all)
                .background()
                .padding(.horizontal)
        }
    }
}
