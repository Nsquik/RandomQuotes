//
//  Quote.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import Foundation
import CoreData


struct Quote: Favourable {
    let id: String
    let content: String
    let author: String
    let series: Series
    
    
    static func random(source: any QuoteSource) async throws -> Quote? {
        return try await source.getRandomQuote()
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

