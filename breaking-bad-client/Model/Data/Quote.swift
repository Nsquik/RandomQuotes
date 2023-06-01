//
//  Quote.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import Foundation
import CoreData


struct Quote<Source: QuoteSource>: Favourable {
    let id: String
    let content: String
    let author: String
    
    static var random:  Quote? {
        get async throws {
            return try await Source.shared.getRandomQuote()
        }
    }
    
    
    typealias FavourableModel = FavouriteQuote
    func mapToFavourable(context: NSManagedObjectContext) -> FavouriteQuote? {
            let favouriteQuote = FavouriteQuote(context: context)
            favouriteQuote.id = UUID(uuidString: self.id)
            favouriteQuote.content = self.content
            return favouriteQuote
        }
}

