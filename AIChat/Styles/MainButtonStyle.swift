//
//  MainButtonStyle.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct MainButtonStyle: ViewModifier {
    var isPerformingTask: Bool = false
    var progressTint: Color = .white
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .font(.headline)
                .foregroundStyle(.white)
                .opacity(isPerformingTask ? 0 : 1)
            
            ProgressView()
                .tint(progressTint)
                .opacity(isPerformingTask ? 1 : 0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.accentColor, in: .rect(cornerRadius: 15))
    }
}

extension View {
    func mainButtonStyle(isPerformingTask: Bool = false, progressTint: Color = .white) -> some View {
        self.modifier(MainButtonStyle(isPerformingTask: isPerformingTask, progressTint: progressTint))
    }
}
