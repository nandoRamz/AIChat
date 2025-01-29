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
                Text(title)
                    .font(.headline)
            }
            
            if let subTitle {
                Text(subTitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var imageView: some View {
        ZStack {
            Rectangle()
                .fill(.quinary)
            if let imageUrlString {
                ImageLoaderView(urlString: imageUrlString)
                
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
        
        PopularCell()
            .padding(.all)
            .background()
            .padding(.horizontal)
            .onTapGesture {
                print("KKKKKKK")
            }
    }
}
