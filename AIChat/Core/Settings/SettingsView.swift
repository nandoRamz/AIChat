//
//  SettingsView.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) private var appState
    var body: some View {
        List {
            logOutButton
        }
        .navigationTitle("Settings")
    }
}

//MARK: - Views
///Views
extension SettingsView {
    private var logOutButton: some View {
        Button(action: { onSignOutPress() }) {
            Text("Log Out")
        }
    }
}

//MARK: - Actions
///Actions
extension SettingsView {
    private func onSignOutPress() {
        appState.updateViewState(isSignedIn: false)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(AppState())
    }
}
