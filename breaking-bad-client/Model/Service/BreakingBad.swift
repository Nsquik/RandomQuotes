//
//  BetterCallSaulAPI.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation


enum BreakingBadContent {
    case character(name: String)
    case randomQuote
}

struct BreakingBad: Fetchable, DataSource {
    static let series: Series = .breakingBad
    typealias Content = BreakingBadContent
    static var baseURL = URL(string: "https://bettercallsaul-api.onrender.com/")!
    
    
    static func getRequestUrl(on: Content) throws -> URL {
        switch on {
        case .randomQuote:
            return baseURL.appending(path: "quotes/random")
        case .character(name: let name):
            let characterNameQueryItem = URLQueryItem(name: "name", value: name)
            let characterUrl = baseURL.appending(path: "characters").appending(queryItems: [characterNameQueryItem])
            return characterUrl
        }
    }
    
    static func getRandomQuote() async throws -> Quote<Self>? {
        //        let url = try self.getRequestUrl(on: .randomQuote)
        //        if let quote: Quote<Self> = try await Fetch.getRequest(url).get()
        //        {
        //            return quote
        //        }
        return nil
    }
    
    static func getCharacter(name: String) async throws -> Character<Self>? {
        //        let url = try self.getRequestUrl(on: .character(name: name))
        //        if let character: Character<Self> = try await Fetch.getRequest(url).get(){
        //            return character
        //        }
        return nil
    }
}

