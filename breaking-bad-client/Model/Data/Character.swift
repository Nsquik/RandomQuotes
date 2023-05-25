//
//  Character.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 03/05/2023.
//

import Foundation

struct Character<Source: CharacterSource> {
    let id: String
    let name: String
    let image: URL
    
    static func getCharacter(name: String) async throws -> Character? {
        return try await Source.shared.getCharacter(name: name)
    }
}

