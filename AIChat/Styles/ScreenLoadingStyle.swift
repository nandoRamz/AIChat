//
//  ScreenLoadingStyle.swift
//  AIChat
//
//  Created by Nando on 2/9/25.
//

import SwiftUI

struct ScreenLoadingStyle: ViewModifier {
    @State private var secondsLoading = 0
    var isShowingScreen: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isShowingScreen {
                content
            }
            else {
                if secondsLoading == 2 {
                    VStack(spacing: 8) {
                        ProgressView()
                        
                        Text("Loading")
                            .foregroundStyle(.secondary)
                        
                    }
                    .background(.clear)
                }
            }
        }
        .task {
            while secondsLoading < 2 {
                try? await Task.sleep(for: .seconds(1))
                secondsLoading += 1
            }
        }
//        .animation(.easeInOut, value: isShowingScreen)
    }
}

extension View {
    func screenLoadingStyle(isShowingScreen: Bool) -> some View {
        self.modifier(ScreenLoadingStyle(isShowingScreen: isShowingScreen))
    }
}
