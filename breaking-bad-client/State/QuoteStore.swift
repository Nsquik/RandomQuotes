//
//  QuoteStore.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import Foundation

class QuoteStore<Source: QuoteDataSource>: FetchableObject {
    @Published var quote: Quote<Source>?
    @Published var author: Character<Source>?
    @Published var series: Series
    @Published var isFavourite: Bool = false
    
    init(series: Series) {
        self.series = series
    }
    
    
    func clear() {
        phase = .initial
        quote = nil
        author = nil
    }
    
    @MainActor
    override func fetchData() async {
        do {
            guard let fetchedQuote = try await Quote<Source>.random else {
                phase = .fail(error: "Failed fetching quote")
                return
            }
            
            let isQuoteFavourite = try Favourites.checkIsFavourite(favourable: fetchedQuote)
            let fetchedCharacter = try await Character<Source>.getCharacter(name: fetchedQuote.author)
            
            quote = fetchedQuote
            author = fetchedCharacter
            phase = .success
            isFavourite = isQuoteFavourite
        } catch {
            print(error)
            phase = .fail(error: error.localizedDescription)
        }
    }
    
    
    func saveAsFavourite() {
        do{
            if let author, let quote {
                let favCharacter = try Favourites.add(favourable: author)
                _ = try Favourites.add(favourable: quote, addRelations: {
                    favQuote in
                    favQuote.character = favCharacter
                    return favQuote
                })

            }
        }catch{
            print(error)
        }
    }
}
