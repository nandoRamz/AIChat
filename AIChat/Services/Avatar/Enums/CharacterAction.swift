//
//  CharacterAction.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import Foundation

enum CharacterAction: String {
    case smiling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, fighting, crying
    
    static var `default`: Self { .working }
}
