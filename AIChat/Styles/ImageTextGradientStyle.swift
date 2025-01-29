//
//  ImageTextGradientStyle.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct ImageTextGradientStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [
                        .black.opacity(0),
                        .black.opacity(0.3),
                        .black.opacity(0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

extension View {
    func imageTextGradientStyle() -> some View {
        self.modifier(ImageTextGradientStyle())
    }
}
