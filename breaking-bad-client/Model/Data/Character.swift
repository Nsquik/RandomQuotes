//
//  Character.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 03/05/2023.
//

import Foundation


struct Character: Decodable {
    let id: String
    let name: String
    let image: URL
    
    
    enum CharacterKeys: String, CodingKey {
        case id = "char_id"
        case name
        case image = "img"
            }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let characterContainer = try container.nestedContainer(keyedBy: CharacterKeys.self)
        
        id = String(try characterContainer.decode(Int.self, forKey: .id))
        name = try characterContainer.decode(String.self, forKey: .name)
        
        let imageUrl = try characterContainer.decode(URL.self, forKey: .image)
        let newImageUrl = URL(string: imageUrl.absoluteString.replacingOccurrences(of: "hhttps://", with: "https://"))!
        image = newImageUrl
    }
    
    init(id: String, name: String, image: URL) {
        self.id = id;
        self.name = name;
        self.image = image
    }
    
    static func getCharacter(name: String, series: Series) async throws -> Character? {
            switch series {
            case .betterCallSaul:
                return try await BetterCallSaul.getCharacter(name: name)
            case .gameOfThrones:
                return try await BetterCallSaul.getCharacter(name: name)
            }
    }
}

