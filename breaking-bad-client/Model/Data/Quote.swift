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
    let series: Series
    
    
    static var random:  Quote? {
        get async throws {
            return try await Source.shared.getRandomQuote()
        }
    }
    
    
    typealias FavouriteModel = FavouriteQuote
    func mapToFavourite(context: NSManagedObjectContext) -> FavouriteQuote {
            let favouriteQuote = FavouriteQuote(context: context)
            favouriteQuote.id = self.id
            favouriteQuote.content = self.content
            favouriteQuote.series = series.getFullName()
            return favouriteQuote
        }
    
    func isFavouritePredicate() -> NSPredicate {
        let seriesPredicate = NSPredicate(format: "series == %@", series.getFullName())
        let contentPredicate = NSPredicate(format: "content == %@", self.content)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [seriesPredicate, contentPredicate])
    }
}

