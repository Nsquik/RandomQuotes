//
//  Quote.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import Foundation

struct Quote<Source: QuoteSource> {
    let id: String
    let content: String
    let author: String
    var isFavourite: Bool? = false
    
    static var random:  Quote? {
        get async throws {
            return try await Source.shared.getRandomQuote()
        }
    }
}

