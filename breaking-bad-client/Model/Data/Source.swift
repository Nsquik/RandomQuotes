//
//  Source.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation


internal protocol QuoteSource {
    static var series: Series {get}
    static func getRandomQuote() async throws -> Quote<Self>?
}

internal protocol CharacterSource {
    static var series: Series {get}
    static func getCharacter(name: String) async throws -> Character<Self>?
}

protocol DataSource: QuoteSource, CharacterSource {}
