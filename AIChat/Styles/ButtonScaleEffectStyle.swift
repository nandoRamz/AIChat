//
//  ScaleEffectStyle.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct ButtonScaleEffectStyle: ViewModifier {
    @State private var isAnimating: Bool = false
    
    var action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimating ? 0.95 : 1)
            .animation(.bouncy, value: isAnimating)
            .onTapGesture {
                startAnimation()
                action?()
            }
    }
}

//MARK: - Methods
///Methods
extension ButtonScaleEffectStyle {
    private func startAnimation() {
        if isAnimating { return }
        
        Task {
            isAnimating.toggle()
            try await Task.sleep(for: .seconds(0.3))
            isAnimating.toggle()
        }
    }
}

extension View {
    func buttonScaleEffectStyle(action: (() -> Void)? = nil) -> some View {
        self.modifier(ButtonScaleEffectStyle(action: action))
    }
}

#Preview {
    VStack {
        Text("HHOHOO")
            .mainButtonStyle()
            .buttonScaleEffectStyle(action: { print("LLLLL")})
        
        
            
    }
    .padding(.horizontal)
}
