//
//  AvatarModel.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import Foundation

typealias AvatarModelKeys = AvatarModel.CodingKeys

struct AvatarModel: Codable, Hashable, Identifiable {
    private(set) var id: String //
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    private(set) var imageUrl: String?
    let createdBy: String? //
    private(set) var timestamp: Date?
    let isActive: Bool
    let isPrivate: Bool
    var viewCount: Int?
    
    init(
        id: String,
        name: String?,
        characterOption: CharacterOption?,
        characterAction: CharacterAction?,
        characterLocation: CharacterLocation?,
        imageUrl: String? = nil,
        createdBy: String?,
        timestamp: Date = .now,
        isActive: Bool = true,
        isPrivate: Bool,
        viewCount: Int? = 0
    ) {
        self.id = id
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.imageUrl = imageUrl
        self.createdBy = createdBy
        self.timestamp = timestamp
        self.isActive = isActive
        self.isPrivate = isPrivate
        self.viewCount = viewCount
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case characterOption = "character_option"
        case characterAction = "character_action"
        case characterLocation = "character_location"
        case imageUrl = "image_url"
        case createdBy = "created_by"
        case timestamp = "timestamp"
        case isActive = "is_active"
        case isPrivate = "is_private"
        case viewCount = "view_count"
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
                createdBy: UUID().uuidString,
                timestamp: .now,
                isPrivate: true,
                viewCount: 2
            ),
            AvatarModel(
                id: UUID().uuidString,
                name: "Beta",
                characterOption: .dog,
                characterAction: .walking,
                characterLocation: .park,
                imageUrl: Constants.randomImageUrlString,
                createdBy: UUID().uuidString,
                timestamp: .now,
                isPrivate: false,
                viewCount: 5
            ),
            AvatarModel(
                id: UUID().uuidString,
                name: "Gamma",
                characterOption: .woman,
                characterAction: .relaxing,
                characterLocation: .forest,
                imageUrl: Constants.randomImageUrlString,
                createdBy: UUID().uuidString,
                timestamp: .now,
                isPrivate: false,
                viewCount: 15
            ),
            AvatarModel(
                id: UUID().uuidString,
                name: "Delta",
                characterOption: .cat,
                characterAction: .sitting,
                characterLocation: .museum,
                imageUrl: Constants.randomImageUrlString,
                createdBy: UUID().uuidString,
                timestamp: .now,
                isPrivate: false,
                viewCount: 0
            )
        ]
    }
}
