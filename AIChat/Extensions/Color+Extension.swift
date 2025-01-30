//
//  Color+Extension.swift
//  AIChat
//
//  Created by Nando on 1/30/25.
//

import SwiftUI

extension Color {
    /// Initialize a Color from a hex string (e.g., "#FF5733" or "#FF5733FF").
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        guard hexSanitized.count == 6 || hexSanitized.count == 8 else {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        
        let r, g, b, a: Double
        if hexSanitized.count == 8 {
            r = Double((rgbValue & 0xFF000000) >> 24) / 255
            g = Double((rgbValue & 0x00FF0000) >> 16) / 255
            b = Double((rgbValue & 0x0000FF00) >> 8) / 255
            a = Double(rgbValue & 0x000000FF) / 255
        } else {
            r = Double((rgbValue & 0xFF0000) >> 16) / 255
            g = Double((rgbValue & 0x00FF00) >> 8) / 255
            b = Double(rgbValue & 0x0000FF) / 255
            a = 1.0
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    /// Convert a Color to a hex string (e.g., "#FF5733" or "#FF5733FF").
    func toHex(includeAlpha: Bool = false) -> String? {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        
        if includeAlpha, components.count == 4 {
            let a = Int(components[3] * 255)
            return String(format: "#%02X%02X%02X%02X", r, g, b, a)
        } else {
            return String(format: "#%02X%02X%02X", r, g, b)
        }
    }
}
