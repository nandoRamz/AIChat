//
//  FeatureCell.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct FeatureCell: View {
    var title: String = "Some Title"
    var subTitle: String = "Some Sub Title"
    var imageName: String? = Constants.randomImageUrlString
    var isLoading: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isLoading {
                Rectangle()
                    .fill(.quinary)
                
                titleView
                    .foregroundStyle(.secondary)
                    .font(.title)
            }
            else {
                ImageLoaderView(urlString: imageName)
                
                titleView
                    .foregroundStyle(.white)
                    .imageTextGradientStyle()
            }
            
        }
        .clipShape(.rect(cornerRadius: 15))
    }
}

//MARK: - Views
///Views
extension FeatureCell {
    private var titleView: some View {
        VStack(alignment: .leading) {
            
            Text(isLoading ? "xxxx-xxxx-xxxx" : title)
                .font(isLoading ? .title2 : .title3)
                .fontWeight(isLoading ? .regular : .semibold)
                .lineLimit(isLoading ? 1 : nil)
                .redacted(reason: isLoading ? .placeholder : [])
            
            Text(isLoading ? "xxxx-xxxx-xxxx-xxxx-xxxx-xxxx-xxxx" : subTitle)
                .font(.callout)
                .lineLimit(isLoading ? 1 : nil)
                .redacted(reason: isLoading ? .placeholder : [])
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("loading") {
    FeatureCell(isLoading: true)
        .padding(.horizontal)
        .frame(height: 250)
}

#Preview("done_loading") {
    FeatureCell(isLoading: false)
        .padding(.horizontal)
        .frame(height: 250)
}

#Preview("together") {
    VStack {
        FeatureCell(isLoading: true)
            .padding(.horizontal)
            .frame(height: 250)
        
        FeatureCell(isLoading: false)
            .padding(.horizontal)
            .frame(height: 250)
    }
}
