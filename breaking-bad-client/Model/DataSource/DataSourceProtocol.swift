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
    func getRandomQuote() async throws -> Quote?
}

internal protocol CharacterSource: CommonSource {
    func getCharacter(name: String) async throws -> Character?
}

protocol QuoteDataSource: QuoteSource, CharacterSource {}

