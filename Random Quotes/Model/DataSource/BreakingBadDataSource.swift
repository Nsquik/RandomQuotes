//
//  BetterCallSaulAPI.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation

struct BreakingBadDataSource: BreakingBadDataSourceProtocol {
    var series: Series = Series.breakingBad
    var baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    public static let shared = BreakingBadDataSource()
}




protocol BreakingBadDataSourceProtocol: Fetchable, QuoteDataSource where Content == BreakingBadContent  {
    var series: Series { get }
}

extension BreakingBadDataSourceProtocol {
    func getRequestUrl(on: Content) throws -> URL {
        switch on {
        case .randomQuote:
            let productionNameQueryItem = URLQueryItem(name: "production", value: series.getFullName())
            return baseURL.appending(path: "quotes/random").appending(queryItems: [productionNameQueryItem])
        case .character(name: let name):
            let characterNameQueryItem = URLQueryItem(name: "name", value: name)
            let productionNameQueryItem = URLQueryItem(name: "production", value: series.getFullName())
            let characterUrl = baseURL.appending(path: "characters").appending(queryItems: [characterNameQueryItem, productionNameQueryItem])
            return characterUrl
        }
    }
    
    func getRandomQuote() async throws -> Quote? {
        let url = try self.getRequestUrl(on: .randomQuote)
        if let bbQuote: BreakingBadQuote = try await Fetch.getRequest(url).get()
        {
            let quote = Quote(id: bbQuote.id, content: bbQuote.quote, author: bbQuote.character, series: series)
            return quote
        }
        return nil
    }
    
    func getCharacter(name: String) async throws -> Character? {
        let url = try self.getRequestUrl(on: .character(name: name))
        if let bbCharacter: BreakingBadCharacter = try await Fetch.getRequest(url).get(){
            
            let character = Character(id: bbCharacter.id, name: bbCharacter.name, image: bbCharacter.image)
            return character
        }
        return nil
    }
}

struct BreakingBadCharacter: Decodable {
    let id: String
    let name: String
    let image: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "character_id"
        case name
        case image = "images"
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let characterContainer = try container.nestedContainer(keyedBy: CodingKeys.self)
        var imagesContainer = try characterContainer.nestedUnkeyedContainer(forKey: .image)
        
        
        
        self.id = String(try characterContainer.decode(Int.self, forKey: .id))
        self.name = try characterContainer.decode(String.self, forKey: .name)
        self.image = URL(string: try imagesContainer.decode(String.self))!
    }
}


struct BreakingBadQuote: Decodable {
    let id: String
    let quote: String
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case quote
        case character
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = String(try container.decode(Int.self, forKey: .id))
        self.quote = try container.decode(String.self, forKey: .quote)
        self.character = try container.decode(String.self, forKey: .character)
    }
}

enum BreakingBadContent {
    case character(name: String)
    case randomQuote
}



