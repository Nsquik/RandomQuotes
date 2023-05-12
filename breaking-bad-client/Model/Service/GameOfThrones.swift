//
//  GameOfThrones.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 11/05/2023.
//

import Foundation

struct GameOfThronesHouse: Decodable {
    let name, slug: String
    
    enum CodingKeys: String, CodingKey {
        case name, slug
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
    }
}

struct GameOfThronesCharacter: Decodable {
    let name, slug: String
    let house: GameOfThronesHouse
    
    enum CodingKeys: String, CodingKey {
        case name, slug, house
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
        house = try container.decode(GameOfThronesHouse.self, forKey: .house)
    }
}


struct GameOfThronesQuote: Decodable {
    let id: String
    let sentence: String
    let character: GameOfThronesCharacter
    
    enum CodingKeys: String, CodingKey {
        case sentence, character
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        sentence = try container.decode(String.self, forKey: .sentence)
        character = try container.decode(GameOfThronesCharacter.self, forKey: .character)
    }
}




enum GameOfThronesContent {
    case character(name: String)
    case randomQuote
}

struct GameOfThrones: Fetchable, DataSource {
    static let series: Series = .gameOfThrones
    typealias Content = GameOfThronesContent
    static let baseURL = URL(string: "https://api.gameofthronesquotes.xyz/v1/")!
    
    static func getRequestUrl(on: Content) throws -> URL {
        switch on {
            case .randomQuote:
                return baseURL.appending(path: "random")
            case .character(name: _):
                // TODO: Add path
                return baseURL
            }
    }
    
    static func getCharacter(name: String) async throws -> Character<Self>? {
        return nil
    }
    
    static func getRandomQuote() async throws -> Quote<Self>? {
            let url = try self.getRequestUrl(on: .randomQuote)
            if let gotQuote: GameOfThronesQuote = try await Fetch.getRequest(url).get()
            {
                let quote = Quote<GameOfThrones>(id: gotQuote.id, content: gotQuote.sentence, author: gotQuote.character.name)
                return quote
            }
            return nil
    }
    
}
