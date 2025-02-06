//
//  AvatarModel.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import Foundation

struct AvatarModel: Codable, Hashable {
    private(set) var id: String //
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    private(set) var imageUrl: String?
    let authorId: String? //
    private(set) var timestamp: Date? //
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case characterOption = "character_option"
        case characterAction = "character_action"
        case characterLocation = "character_location"
        case imageUrl = "image_url"
        case authorId = "created_by"
        case timestamp = "timestamp"
    }
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
    
    mutating func updateId(with id: String) {
        self.id = id
    }
    
    mutating func updateTimestamp(with date: Date) {
        self.timestamp = date
    }
    
    mutating func updateImageUrl(with urlString: String) {
        self.imageUrl = urlString
    }
}


extension AvatarModel {
    static var sample: AvatarModel { samples[0] }
    
    static var samples: [AvatarModel] {
        [
            AvatarModel(
                id: UUID().uuidString,
                name: "Alpha",
                characterOption: .alien,
                characterAction: .drinking,
                characterLocation: .space,
                imageUrl: Constants.randomImageUrlString,
                authorId: UUID().uuidString,
                timestamp: .now
            ),
            AvatarModel(
                id: UUID().uuidString,
                name: "Beta",
                characterOption: .dog,
                characterAction: .walking,
                characterLocation: .park,
                imageUrl: Constants.randomImageUrlString,
                authorId: UUID().uuidString,
                timestamp: .now
            ),
            AvatarModel(
                id: UUID().uuidString,
                name: "Gamma",
                characterOption: .woman,
                characterAction: .relaxing,
                characterLocation: .forest,
                imageUrl: Constants.randomImageUrlString,
                authorId: UUID().uuidString,
                timestamp: .now
            ),
            AvatarModel(
                id: UUID().uuidString,
                name: "Delta",
                characterOption: .cat,
                characterAction: .sitting,
                characterLocation: .museum,
                imageUrl: Constants.randomImageUrlString,
                authorId: UUID().uuidString,
                timestamp: .now
            )
        ]
    }
}
