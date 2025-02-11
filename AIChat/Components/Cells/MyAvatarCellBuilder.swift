//
//  MyAvatarCellBuilder.swift
//  AIChat
//
//  Created by Nando on 2/10/25.
//

import SwiftUI

struct MyAvatarCellBuilder: View {
    @State private var isPrivate: Bool
    
    var isLoading: Bool
    var avatar: AvatarModel
    var onMenuItemPress: ((AvatarMenuItem) -> Void)?
    
    init(
        isLoading: Bool = true,
        avatar: AvatarModel = AvatarModel.sample,
        onMenuItemPress: ((AvatarMenuItem) -> Void)? = nil
    ) {
        _isPrivate = State(wrappedValue: avatar.isPrivate)
        self.isLoading = isLoading
        self.avatar = avatar
        self.onMenuItemPress = onMenuItemPress
    }
    
    var body: some View {
        HStack {
            PopularCell(
                imageUrlString: avatar.imageUrl,
                title: avatar.name,
                subTitle: nil,
                isLoading: isLoading
            )
            
            if !isLoading {
                ellipsisMenu
            }
        }
        .overlay(alignment: .leading) {
            if isPrivate && !isLoading { privateIcon }
        }
    }
}

//MARK: - Views
///Views
extension MyAvatarCellBuilder {
    private var privateIcon: some View {
        Image(systemName: "eye.slash")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.secondary)
            .frame(width: 12)
            .frame(width: 16, height: 16)
            .offset(x: -16)
    }
    
    private var ellipsisMenu: some View {
        Menu {
            ForEach(AvatarMenuItem.allCases) { item in
                let isShowingItem = AvatarMenuItem.isShowingMenuItem(item, isAvatarPrivate: isPrivate)
                
                if isShowingItem {
                    Button(
                        item.title,
                        systemImage: item.systemImage,
                        role: item == .delete ? .destructive : nil,
                        action: { onMenuAvatarItemPress(item) }
                    )
                }
            }
        } label: {
            Image(systemName: "ellipsis")
                .fontWeight(.semibold)
                .frame(width: 28, height: 28)
                .tint(.primary)
                .background(.primary.opacity(0.0001))
        }
    }
}

//MARK: - Actions
///Actions
extension MyAvatarCellBuilder {
    private func onMenuAvatarItemPress(_ item: AvatarMenuItem) {
        if item == .makePublic || item == .makePrivate { isPrivate.toggle() }
        onMenuItemPress?(item)
    }
}

//MARK: - Methods
///Methods
extension MyAvatarCellBuilder {
    private func isShowingMenuItem(_ item: MyAvatarCellBuilder) {
        
    }
}

//MARK: - Enums
///Enums
extension MyAvatarCellBuilder {
    enum AvatarMenuItem: String, Identifiable, CaseIterable {
        case edit
        case makePrivate
        case makePublic
        case delete
        
        var id: String { self.rawValue }
        var title: String {
            switch self {
            case .delete: "Delete"
            case .makePrivate: "Make it Private"
            case .makePublic: "Make it Public"
            case .edit: "Edit"
            }
        }
        
        var systemImage: String {
            switch self {
            case .delete: "trash"
            case .makePrivate: "eye.slash"
            case .makePublic: "network"
            case .edit: "pencil"
            }
        }
        
        static func isShowingMenuItem(_ item: AvatarMenuItem, isAvatarPrivate: Bool) -> Bool {
            if item == .makePrivate && isAvatarPrivate { return false }
            if item == .makePublic && !isAvatarPrivate { return false }
            return true
        }
    }
}

//MARK: - Previews
#Preview("loading") {
    MyAvatarCellBuilder()
        .padding(.horizontal)
}

#Preview("done_loading") {
    MyAvatarCellBuilder(isLoading: false)
        .padding(.horizontal)
}
