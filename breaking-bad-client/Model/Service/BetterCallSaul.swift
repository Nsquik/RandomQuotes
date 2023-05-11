//
//  BetterCallSaulAPI.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation


enum BetterCallSaulContent {
    case character(name: String)
    case randomQuote
}

enum BetterCallSaulError: Error {
    case urlParsingError
}

struct BetterCallSaul: Fetchable, QuoteSource, CharacterSource {
    typealias Content = BetterCallSaulContent
    static let baseURL = URL(string: "https://bettercallsaul-api.onrender.com/")!
    

    internal static func getRequestUrl(on: Content) throws -> URL {
        guard let url: URL = {
            switch on {
            case .character(let name):
                let characterUrl = BetterCallSaul.baseURL.appendingPathComponent("characters")
                var characterComponent = URLComponents(url: characterUrl, resolvingAgainstBaseURL: true)
                let characterQueryItem = URLQueryItem(name: "name", value: name)
                characterComponent?.queryItems = [characterQueryItem]
                return (characterComponent?.url)
            case .randomQuote:
                return BetterCallSaul.baseURL.appendingPathComponent("quotes/random")
            }
        }() else {
            throw BetterCallSaulError.urlParsingError
        }
        
        return url
  }
    
    static func getRandomQuote() async throws -> Quote<Self>? {
        let url = try self.getRequestUrl(on: .randomQuote)
        if let quote: Quote<Self> = try await Fetch.getRequest(url).get()
        {
            return quote
        }
        return nil
    }
    
    static func getCharacter(name: String) async throws -> Character<Self>? {
        let url = try self.getRequestUrl(on: .character(name: name))
        if let character: Character<Self> = try await Fetch.getRequest(url).get(){
            return character
        }
        return nil
    }
}

