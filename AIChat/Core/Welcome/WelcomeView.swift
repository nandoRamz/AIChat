//
//  WelcomeView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            Text("Welcome")
                .navigationTitle("Welcome")
        }
    }
}

#Preview {
    WelcomeView()
}
