//
//  CharacterOption.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import Foundation

enum CharacterOption: String, CaseIterable, Hashable, Codable  {
    case man, woman, alien, dog, cat
    
    static var `default`: Self { .man }
}

