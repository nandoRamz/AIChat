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
        ScrollView {
            VStack(spacing: 32) {
                ForEach(Setting.Group.allCases) { group in
                    VStack(spacing: 8) {
                        if group != .logOut {
                            ListTitleView(text: group.rawValue)
                                .padding(.horizontal)
                        }
                        
                        VStack(spacing: 0) {
                            ForEach(group.items) { item in
                                navButton(
                                    title: item.title,
                                    subTitle: nil,
                                    foregroundStyle: item.foregroundStyle,
                                    isShowingChevron: isShowingChevron(for: item)
                                )
                                .listStyle(for: item, in: group.items)
                            }
                        }
                        .padding(.horizontal)
                        .background()
                        .clipShape(.rect(cornerRadius: 15))
                    }
                }
            }
            .padding(.all)
            
        }
        .background(Color(uiColor: .secondarySystemBackground))
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
    
    private func navButton(
        title: String,
        subTitle: String? = nil,
        foregroundStyle: Color = .secondary,
        isShowingChevron: Bool = true
    ) -> some View {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(foregroundStyle)

            
            if subTitle != nil || isShowingChevron {
                HStack(alignment: .firstTextBaseline,spacing: 8) {
                    if let subTitle {
                        Text(subTitle)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    
                    if isShowingChevron {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
            }
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

//MARK: - Methods
///Methods
extension SettingsView {
    private func isShowingSubtitle(for setting: Setting) -> Bool {
        switch setting {
        case .accountStatus, .version, .buildVersion: true
        default: false
        }
    }
    
    private func isShowingChevron(for setting: Setting) -> Bool {
        switch setting {
        case .accountStatus, .version, .buildVersion, .contact: true
        default: false
        }
    }
}

//MARK: - Enums
///Enums
extension SettingsView {
    enum Setting: String, Identifiable, CaseIterable {
        case logOut = "log out"
        case deleteAccount = "delete account"
        case accountStatus = "account status"
        case version
        case buildVersion = "build version"
        case contact
        
        var id: String { return self.rawValue }
        var title: String { return self.rawValue.capitalized }
        var foregroundStyle: Color {
            switch self {
            case .deleteAccount, .logOut: Color.red
            case .contact: Color.blue
            default: Color.primary
            }
        }
        
        enum Group: String, Identifiable, CaseIterable {
            case account, application, logOut
            var id: String { return self.rawValue }
            var items: [Setting] {
                switch self {
                case .account: return [.accountStatus, .deleteAccount]
                case .application: return [.version, .buildVersion, .contact]
                case .logOut: return [.logOut]
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(AppState())
    }
}


