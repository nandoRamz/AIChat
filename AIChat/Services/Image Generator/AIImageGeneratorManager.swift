//
//  AIImageGeneratorManager.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

@Observable
class AIImageGeneratorManager {
    private let service: AIImageGeneratorService
    
    init(service: AIImageGeneratorService) {
        self.service = service
    }
    
    func generateImage(from prompt: String) async throws -> UIImage {
        try await service.generateImage(from: prompt)
    }
}
