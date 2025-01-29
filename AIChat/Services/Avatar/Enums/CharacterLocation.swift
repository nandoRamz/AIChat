//
//  CharacterLocation.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import Foundation

enum CharacterLocation: String, CaseIterable, Hashable  {
    case park, mall, museum, city, desert, forest, space
    
    static var `default`: Self { .space }
}
