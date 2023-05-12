//
//  QuoteStore.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import Foundation

class DataStore<TDataSource: DataSource>: FetchableObject {
    @Published var quote: Quote?
    @Published var author: Character?
    @Published var series: Series
    
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
            guard let fetchedQuote = try await TDataSource.getRandomQuote() else {
                phase = .fail(error: "Failed fetching quote")
                return
            }
            
            let fetchedCharacter = try await TDataSource.getCharacter(name: fetchedQuote.author)
            
            quote = fetchedQuote
            author = fetchedCharacter
            phase = .success
        } catch {
            print(error)
            phase = .fail(error: error.localizedDescription)
        }
    }
    
}
