//
//  ListStyle.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import SwiftUI

struct ListStyle<T: Hashable>: ViewModifier {
    var items: [T]
    var item: T
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 11)
            .background(
                Divider()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .opacity(items.last == item ? 0 : 1)
            )
    }
}

extension View {
    func listStyle<T: Hashable>(for item: T, in items: [T]) -> some View {
        self.modifier(ListStyle(items: items, item: item))
    }
}
