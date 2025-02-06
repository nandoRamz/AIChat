//
//  AvatarService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

protocol AvatarService {
    func save(_ avatar: AvatarModel, withImage: UIImage, isPrivate: Bool) async throws
}
