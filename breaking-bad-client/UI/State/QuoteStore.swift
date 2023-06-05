//
//  QuoteStore.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import Foundation

class QuoteStore<Source: QuoteDataSource>: FetchableObject {
    @Published var quote: Quote?
    @Published var author: Character?
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
            guard let fetchedQuote = try await Quote.random(source: Source.shared) else {
                phase = .fail(error: "Failed fetching quote")
                return
            }
            
            
            let fetchedCharacter = try await Character.getCharacter(name: fetchedQuote.author, source: Source.shared)
            
            quote = fetchedQuote
            author = fetchedCharacter
            phase = .success
            try await checkIsFavourite()
        } catch {
            print(error)
            phase = .fail(error: error.localizedDescription)
        }
    }
    
    @MainActor
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
    
    @MainActor
    func checkIsFavourite() async throws {
        
        if let quote {
            let isQuoteFavourite = try Favourites.checkIsFavourite(favourable: quote)
            isFavourite = isQuoteFavourite
        }
    }
}
