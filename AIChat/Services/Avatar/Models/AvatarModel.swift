//
//  AvatarModel.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import Foundation

struct AvatarModel: Hashable {
    let avatarId: String //
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let authorId: String? //
    let dateCreated: Date? //    
}

//MARK: - Methods
///Methods
extension AvatarModel {
    func characterDescription() -> String {
        let unwrappedOption = characterOption ?? .default
        let unwrappedAction = characterAction ?? .default
        let unwrappedLocation = characterLocation ?? .default
        
        return "A \(unwrappedOption.rawValue) that is \(unwrappedAction.rawValue) in the \(unwrappedLocation.rawValue)."
    }
}


extension AvatarModel {
    static var sample: AvatarModel { samples[0] }
    
    static var samples: [AvatarModel] {
        [
            AvatarModel(avatarId: UUID().uuidString, name: "Alpha", characterOption: .alien, characterAction: .drinking, characterLocation: .space, profileImageName: Constants.randomImageUrlString, authorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarId: UUID().uuidString, name: "Beta", characterOption: .dog, characterAction: .walking, characterLocation: .park, profileImageName: Constants.randomImageUrlString, authorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarId: UUID().uuidString, name: "Gamma", characterOption: .woman, characterAction: .relaxing, characterLocation: .forest, profileImageName: Constants.randomImageUrlString, authorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarId: UUID().uuidString, name: "Delta", characterOption: .cat, characterAction: .sitting, characterLocation: .museum, profileImageName: Constants.randomImageUrlString, authorId: UUID().uuidString, dateCreated: .now)
        ]
    }
}
