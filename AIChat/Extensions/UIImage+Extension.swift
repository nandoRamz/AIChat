//
//  UIImage+Extension.swift
//  AIChat
//
//  Created by Nando on 2/6/25.
//

import SwiftUI

extension UIImage {
    func createTempUrl() async throws -> URL {
        let imageData = self.jpegData(compressionQuality: 1)
        
        let tempDirectory = FileManager.default.temporaryDirectory
        
        let uid = UUID().uuidString + ".jpg"
        let url = tempDirectory.appending(component: uid, directoryHint: .inferFromPath)
        
        do {
            try imageData?.write(to: url)
            return url 
        }
        catch {
            throw error
        }
    }
}

