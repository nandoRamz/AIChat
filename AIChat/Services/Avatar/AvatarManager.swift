//
//  AvatarManager.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

@Observable
class AvatarManager {
    let service: AvatarService
    
    init(service: AvatarService) {
        self.service = service
    }
    
    func save(_ avatar: AvatarModel, withImage: UIImage, isPrivate: Bool) async throws {
        try await service.save(avatar, withImage: withImage, isPrivate: isPrivate)
    }
}
