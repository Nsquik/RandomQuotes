//
//  GameOfThrones.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 11/05/2023.
//

import Foundation

struct GameOfThronesDataSource: Fetchable, QuoteDataSource {
    internal typealias Content = GameOfThronesContent
    let baseURL = URL(string: "https://api.gameofthronesquotes.xyz/v1/")!
    let characterURL = URL(string: "https://thronesapi.com/api/v2/")!
    static private var characterList: [GameOfThronesCharacter]? = nil
    
    public static let shared = GameOfThronesDataSource()
    
    
    
    func getRequestUrl(on: Content) throws -> URL {
        switch on {
        case .randomQuote:
            return baseURL.appending(path: "random")
        case .characters:
            return characterURL.appending(path: "Characters")
        }
    }
    
    private func getCharacterList() async throws -> [GameOfThronesCharacter] {
        if GameOfThronesDataSource.characterList != nil {
            return GameOfThronesDataSource.characterList ?? []
        }
        
        let url = try getRequestUrl(on: .characters)
        let gotCharacterList: [GameOfThronesCharacter] = try await Fetch.getRequest(url).get()
        GameOfThronesDataSource.characterList = gotCharacterList
        
        return gotCharacterList
    }
    
    func getCharacter(name: String) async throws -> Character? {
        let gotCharacterList = try await getCharacterList()
        
        guard let gotCharacter = gotCharacterList.first(where: {character in
            return name.contains(character.firstName) && name.contains(character.lastName)
        })
        else{
            return nil
        }
        
        return Character(id: gotCharacter.id, name: gotCharacter.fullName, image: gotCharacter.image)
        
    }
    
    func getRandomQuote() async throws -> Quote? {
        let url = try getRequestUrl(on: .randomQuote)
        if let gotQuote: GameOfThronesQuote = try await Fetch.getRequest(url).get()
        {
            let quote = Quote(id: gotQuote.id, content: gotQuote.sentence, author: gotQuote.character, series: Series.gameOfThrones)
            return quote
        }
        return nil
    }
    
}




fileprivate struct GameOfThronesCharacter: Decodable {
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
        
        
        firstName = try characterContainer.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName = try characterContainer.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        fullName = try characterContainer.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        id = fullName
        image = URL(string: try characterContainer.decodeIfPresent(String.self, forKey: .imageUrl) ?? "")!
    }
}


fileprivate struct GameOfThronesQuote: Decodable {
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
        id = try container.decode(String.self, forKey: .sentence)
        sentence = try container.decode(String.self, forKey: .sentence)
        
        let characterContainer = try container.nestedContainer(keyedBy: CharacterKeys.self, forKey: .character)
        character = try characterContainer.decode(String.self, forKey: .name)
    }
}


enum GameOfThronesContent {
    case characters
    case randomQuote
}

