//
//  OnboardingColorView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct OnboardingColorView: View {
    @State private var selectedColor: Color?
    private let colors: [Color] = [.red, .green, .orange, .blue, .mint, .purple, .cyan, .teal, .indigo]
    
    var body: some View {
        ScrollView {
            colorGrid
        }
        .contentMargins(.all, 16)
        .navigationTitle("Select a profile color")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(
            edge: .bottom,
            alignment: .center,
            spacing: 16,
            content: {
                if let selectedColor {
                    continueNavLink
                        .padding()
                        .background()
                        .transition(.move(edge: .bottom))
                }
                
            }
        )
        .animation(.bouncy, value: selectedColor)
    }
}

//MARK: - Views
///Views
extension OnboardingColorView {
    private var continueNavLink: some View {
        NavigationLink {
            OnboardingCompletedView()
        } label: {
            Text("Continue")
                .mainButtonStyle()
        }
    }
    
    private var colorGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible()), count: 3),
            spacing: 16
        ) {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(.accent)
                    .overlay {
                        Circle()
                            .fill(color)
                            .padding(selectedColor == color ? 8 : 0)
                            .onTapGesture { onColorPress(color) }
                    }
            }
        }
    }
}

//MARK: - Actions
///Actions
extension OnboardingColorView {
    private func onColorPress(_ color: Color) {
        selectedColor = color
    }
}

#Preview {
    NavigationStack {
        OnboardingColorView()
    }
}
