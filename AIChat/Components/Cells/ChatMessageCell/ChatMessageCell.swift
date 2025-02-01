//
//  ChatMessageCell.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import SwiftUI

struct ChatMessageCell: View {
    var imageUrlString: String?  = Constants.randomImageUrlString
    var text: String = "Some random message"
    var foregroundStyle: Color = .primary
    var background: AnyShapeStyle = AnyShapeStyle(.ultraThinMaterial)
    var alignment: Alignment = .leading
    var onAvatarPress: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .bottom) {
            if alignment != .trailing {
                ImageLoaderView(urlString: imageUrlString)
                    .frame(width: 34, height: 34)
                    .clipShape(.circle)
                    .padding(.bottom, 7)
                    .onTapGesture { onAvatarPress?() }
            }
            
            Text(text)
                .foregroundStyle(foregroundStyle)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(minHeight: 34 + 14)
                .background(background)
                .clipShape(.rect(cornerRadius: 15))
                .padding(.leading, alignment == .leading ? 0 : 34 + 16)
                .padding(.trailing, alignment == .trailing ? 0 : 34 + 16)
        }
        .frame(maxWidth: .infinity, alignment: alignment)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ChatMessageCell(text: "This is some really long text that should span into 2 lines.")
            
            ChatMessageCell( )
            
            ChatMessageCell(
                text: "This is some really long text. This is some reallysssfsdasd sf as dasdf long text.",
                foregroundStyle: .white,
                background: AnyShapeStyle(Color.accentColor),
                alignment: .trailing
            )
            
        }
        .padding(.horizontal)
    }
}
