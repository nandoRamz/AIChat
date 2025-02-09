//
//  NoResultsView.swift
//  AIChat
//
//  Created by Nando on 2/9/25.
//

import SwiftUI

struct NoResultsView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var message: String = "Sorry we couldn't find any results. Please try again later."
    var height: CGFloat = 200
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(isDarkMode ? .ultraThinMaterial : .bar)
            .overlay {
                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            }
            .frame(height: height)
    }
}

#Preview {
    NoResultsView()
        .padding(.horizontal)
}
