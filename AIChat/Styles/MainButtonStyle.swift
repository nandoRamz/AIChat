//
//  MainButtonStyle.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct MainButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.accentColor, in: .rect(cornerRadius: 15))
    }
}

extension View {
    func mainButtonStyle() -> some View {
        self.modifier(MainButtonStyle())
    }
}
