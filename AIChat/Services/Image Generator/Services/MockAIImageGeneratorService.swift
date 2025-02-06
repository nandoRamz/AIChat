//
//  MockAIImageGeneratorService.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

struct MockAIImageGeneratorService: AIImageGeneratorService {
    func generateImage(from prompt: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(3))
        return UIImage(resource: .appIconInternal)
    }
}
