//
//  Quote.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import Foundation

struct Quote: Decodable {
    let id: String
    let content: String
    let author: String
    
    
    
    
    enum QuoteKeys: String, CodingKey {
        case id = "quote_id"
        case quote
        case author
    }
    
    init(from decoder: Decoder) throws {
        let quoteContainer = try decoder.container(keyedBy: QuoteKeys.self)

        id = String(try quoteContainer.decode(Int.self, forKey: .id))
        content = try quoteContainer.decode(String.self, forKey: .quote)
        author = try quoteContainer.decode(String.self, forKey: .author)
        // TODO: Add decoding series in decoder.
    }
    
    init(id: String, quote: String, author: String, series: Series) {
        self.id = id
        self.content = quote
        self.author = author
     
    }
    
    
    static func getRandom(series: Series) async throws -> Quote? {
        switch series {
        case .betterCallSaul:
            return try await BetterCallSaul.randomQuote
        case .gameOfThrones:
            return try await BetterCallSaul.randomQuote
        }
    }
}
