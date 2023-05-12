//
//  Quote.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import Foundation

struct Quote {
    let id: String
    let content: String
    let author: String
    
    static func getRandom(series: Series) async throws -> Quote? {
        switch series {
        case .gameOfThrones:
            return try await GameOfThronesDataSource.getRandomQuote()
        case .breakingBad:
            return try await BreakingBadDataSource.getRandomQuote()
        case .betterCallSaul:
            return try await BetterCallSaulDataSource.getRandomQuote()
        }
    }
}

