//
//  GetViewSizeModifier.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import SwiftUI

struct ViewSizeModifier: ViewModifier {
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader {
                    let size = $0.size
                    Color.clear
                        .preference(key: ViewSizePreferenceKey.self, value: size)
                        .onPreferenceChange(ViewSizePreferenceKey.self, perform: { size in
                            self.size = size
                        })
                }
            )
    }
}

fileprivate struct ViewSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func getSize(_ size: Binding<CGSize>) -> some View {
        self.modifier(ViewSizeModifier(size: size))
    }
}
