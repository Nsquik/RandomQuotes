//
//  GameOfThrones.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 11/05/2023.
//

import Foundation

enum GameOfThronesContent {
    case character(name: String)
    case randomQuote
}

struct GameOfThrones: Fetchable, QuoteSource, CharacterSource {
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
            if let quote: Quote<Self> = try await Fetch.getRequest(url).get()
            {
                return quote
            }
            return nil
    }
    
}
