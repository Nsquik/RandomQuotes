//
//  QuoteStore.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import Foundation

class DataStore<Source: DataSource>: FetchableObject {
    @Published var quote: Quote<Source>?
    @Published var author: Character<Source>?
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
            guard let fetchedQuote = try await Quote<Source>.random else {
                phase = .fail(error: "Failed fetching quote")
                return
            }
            
            let fetchedCharacter = try await Character<Source>.getCharacter(name: fetchedQuote.author)
            
            quote = fetchedQuote
            author = fetchedCharacter
            phase = .success
        } catch {
            print(error)
            phase = .fail(error: error.localizedDescription)
        }
    }
}
