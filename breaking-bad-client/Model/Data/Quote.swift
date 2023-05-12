//
//  Quote.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import Foundation




struct Quote<T: QuoteSource> {
    let id: String
    let content: String
    let author: String

    static var random: Quote? {
        get async throws {
            try await T.self.getRandomQuote()
        }
    }
}

