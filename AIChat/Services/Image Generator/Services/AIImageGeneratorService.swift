//
//  AIImageGeneratorService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

protocol AIImageGeneratorService {
    func generateImage(from prompt: String) async throws -> UIImage
}
