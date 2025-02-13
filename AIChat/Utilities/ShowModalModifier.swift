//
//  ShowModalModifier.swift
//  AIChat
//
//  Created by Nando on 2/1/25.
//

import SwiftUI

struct ShowModalModifier<T: View>: ViewModifier {
    
    private var animationDuration: CGFloat { 0.3 }
    @State private var isAnimatingBackground: Bool = false
    @State private var isAnimatingContent: Bool = false
    @State private var isAnimating: Bool = false

    
    @Binding var isPresented: Bool
    @ViewBuilder var content: T
    var slide: Edge = .leading
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    ZStack {
                        if isAnimatingBackground {
                            Color.black.opacity(0.5)
                                .ignoresSafeArea()
                                .zIndex(1)
                                .onAppear { isAnimatingContent = true }
                                .onDisappear { isPresented.toggle() }
                                .onTapGesture { onDissmissPress() }
                        }
                        
                        if isAnimatingContent {
                            self.content
                                .padding(.horizontal, 32)
                                .transition(.move(edge: slide))
                                .frame(maxHeight: .infinity)
                                .frame(maxWidth: .infinity)
                                .zIndex(2)
                        }
                    }
                    .animation(.easeInOut(duration: animationDuration), value: isAnimatingBackground)
                    .animation(.easeInOut(duration: animationDuration), value: isAnimatingContent)
                }
            }
            .onChange(of: isPresented) { _, newValue in
                if newValue { isAnimatingBackground.toggle() }
            }
    }
}

//MARK: - Methods
///Methods
extension ShowModalModifier {
    
    private func onDissmissPress() {
        Task {
            isAnimatingContent.toggle()
            try await Task.sleep(for: .seconds(0.1))
            isAnimatingBackground.toggle()
        }
    }
}

extension View {
    func showModal<Content: View>(
        isPresented: Binding<Bool>,
        slide: Edge = .leading,
        @ViewBuilder content: () -> Content
    ) -> some View {
        self.modifier(
            ShowModalModifier(
                isPresented: isPresented,
                content: content,
                slide: slide
            )
        )
    }
}


#Preview {
    NavigationStack {
        ChatMessageListView(avatar: .sample)
    }
}
