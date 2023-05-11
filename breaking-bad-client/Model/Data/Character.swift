//
//  Character.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 03/05/2023.
//

import Foundation

protocol CharacterSource {
    static func getCharacter(name: String) async throws -> Character<Self>?
}


struct Character<T: CharacterSource>: Decodable {
    let id: String
    let name: String
    let image: URL
        
    static func getCharacter(name: String) async throws -> Character? {
        return try await T.self.getCharacter(name: name)
    }
}

