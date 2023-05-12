//
//  GameOfThrones.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 11/05/2023.
//

import Foundation



struct GameOfThronesCharacter: Decodable {
    let id: String
    let fullName: String
    let firstName: String
    let lastName: String
    let image: URL
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, fullName, imageUrl
    }
    
    init(from decoder: Decoder) throws {
        let characterContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID().uuidString
        firstName = try characterContainer.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName = try characterContainer.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        fullName = try characterContainer.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        image = URL(string: try characterContainer.decodeIfPresent(String.self, forKey: .imageUrl) ?? "")!
    }
}


struct GameOfThronesQuote: Decodable {
    let id: String
    let sentence: String
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case sentence, character
    }
    
    enum CharacterKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        sentence = try container.decode(String.self, forKey: .sentence)
        
        let characterContainer = try container.nestedContainer(keyedBy: CharacterKeys.self, forKey: .character)
        character = try characterContainer.decode(String.self, forKey: .name)
    }
}


enum GameOfThronesContent {
    case characters
    case randomQuote
}

struct GameOfThrones: Fetchable, DataSource {
    static let series: Series = .gameOfThrones
    typealias Content = GameOfThronesContent
    static let baseURL = URL(string: "https://api.gameofthronesquotes.xyz/v1/")!
    static let characterURL = URL(string: "https://thronesapi.com/api/v2/")!
    static var characterList: [GameOfThronesCharacter]? = nil
    
    static func getRequestUrl(on: Content) throws -> URL {
        switch on {
        case .randomQuote:
            return baseURL.appending(path: "random")
        case .characters:
            return characterURL.appending(path: "Characters")
        }
    }
    
    private static func getCharacterList() async throws -> [GameOfThronesCharacter] {
        if let characterList {
            return characterList
        }
        
        let url = try getRequestUrl(on: .characters)
        let gotCharacterList: [GameOfThronesCharacter] = try await Fetch.getRequest(url).get()
        characterList = gotCharacterList
        
        return gotCharacterList
    }
    
    static func getCharacter(name: String) async throws -> Character<Self>? {
        let gotCharacterList = try await getCharacterList()
        
        guard let gotCharacter = gotCharacterList.first(where: {character in
            return name.contains(character.firstName) && name.contains(character.lastName)
        })
        else{
            return nil
        }
        
        return Character(id: gotCharacter.id, name: gotCharacter.fullName, image: gotCharacter.image)
        
    }
    
    static func getRandomQuote() async throws -> Quote<Self>? {
        let url = try getRequestUrl(on: .randomQuote)
        if let gotQuote: GameOfThronesQuote = try await Fetch.getRequest(url).get()
        {
            let quote = Quote<GameOfThrones>(id: gotQuote.id, content: gotQuote.sentence, author: gotQuote.character)
            return quote
        }
        return nil
    }
    
}
