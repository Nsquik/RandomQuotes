//
//  Quote.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import Foundation

protocol QuoteSource {
    static func getRandomQuote() async throws -> Quote<Self>?
}

struct Quote<T: QuoteSource>: Decodable {
    let id: String
    let content: String
    let author: String

    static var random: Quote? {
        get async throws {
            try await T.self.getRandomQuote()
        }
    }
}

