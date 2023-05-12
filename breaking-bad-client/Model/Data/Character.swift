//
//  Character.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 03/05/2023.
//

import Foundation

struct Character {
    let id: String
    let name: String
    let image: URL
    
    static func getCharacter(series: Series, name: String) async throws -> Character? {
        switch series {
            case .gameOfThrones:
                return try await GameOfThronesDataSource.getCharacter(name: name)
            case .breakingBad:
                return try await BreakingBadDataSource.getCharacter(name: name)
            case .betterCallSaul:
                return try await BetterCallSaulDataSource.getCharacter(name: name)
            }
    }
}

