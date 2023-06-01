//
//  Source.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation


internal protocol CommonSource {
    static var shared: Self {get}
}

internal protocol QuoteSource: CommonSource {
    func getRandomQuote() async throws -> Quote<Self>?
}

internal protocol CharacterSource: CommonSource {
    func getCharacter(name: String) async throws -> Character<Self>?
}

protocol DataSource: QuoteSource, CharacterSource {}

