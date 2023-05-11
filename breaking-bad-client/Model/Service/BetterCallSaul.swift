//
//  BetterCallSaulAPI.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation

struct BetterCallSaul {
    static let baseURL = URL(string: "https://bettercallsaul-api.onrender.com/")!

    enum Content {
        case character(name: String)
        case randomQuote
    }
    
    enum BetterCallSaulApiError: Error {
        case urlParsingError
    }
        
    
    private static func getRequestUrl(on: Content) throws -> URL {
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
            throw BetterCallSaulApiError.urlParsingError
        }
        
        return url
  }
    
    static var randomQuote: Quote? {
        get async throws {
            let url = try self.getRequestUrl(on: .randomQuote)
            if let quote: Quote = try await Network.getRequest(url).get()
            {
                return quote
            }
            return nil
        }
    }
    
    static func getCharacter(name: String) async throws -> Character? {
        let url = try self.getRequestUrl(on: .character(name: name))
        if let character: Character = try await Network.getRequest(url).get(){
            return character
        }
        return nil
    }
}
