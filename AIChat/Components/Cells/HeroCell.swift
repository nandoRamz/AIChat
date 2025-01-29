//
//  HeroCell.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct HeroCell: View {
    var title: String? = "Some Title"
    var subTitle: String? = "Some Sub Title"
    var imageName: String? = Constants.randomImageUrlString
    
    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundView
            
            if title != nil || subTitle != nil {
                titleView
            }
        }
        .clipShape(.rect(cornerRadius: 15))
    }
}

//MARK: - Views
///Views
extension HeroCell {
    private var titleView: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.headline)
            }
            
            if let subTitle {
                Text(subTitle)
                    .font(.subheadline)
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .imageTextGradientStyle()
    }
    
    private var backgroundView: some View {
        ZStack {
            if let imageName { ImageLoaderView(urlString: imageName) }
            else { Rectangle().fill(.quinary) }
        }
        
    }
}

#Preview {
    ScrollView {
        VStack {
            HeroCell()
                .frame(width: 200, height: 300)
            
            HeroCell(title: nil, subTitle: nil, imageName: nil)
                .frame(width: 200, height: 300)
            
            HeroCell(title: "Title", subTitle: nil, imageName: nil)
                .frame(width: 200, height: 300)
            
            HeroCell(title: "Title", subTitle: nil, imageName: Constants.randomImageUrlString)
                .frame(width: 300, height: 200)
            
            HeroCell(title: nil, subTitle: "SubTitle", imageName: Constants.randomImageUrlString)
                .frame(width: 200, height: 300)
            
        }
    }
}
