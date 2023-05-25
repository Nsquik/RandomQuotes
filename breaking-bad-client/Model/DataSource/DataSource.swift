//
//  Source.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation


internal protocol QuoteSource {
    static var shared: Self {get}
    func getRandomQuote() async throws -> Quote<Self>?
}

internal protocol CharacterSource {
    static var shared: Self {get}
    func getCharacter(name: String) async throws -> Character<Self>?
}

protocol DataSource: QuoteSource, CharacterSource {}
