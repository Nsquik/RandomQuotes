//
//  Source.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation


internal protocol QuoteSource {
    static func getRandomQuote() async throws -> Quote?
}

internal protocol CharacterSource {
    static func getCharacter(name: String) async throws -> Character?
}

protocol DataSource: QuoteSource, CharacterSource {}
