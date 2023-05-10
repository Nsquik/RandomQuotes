//
//  QuoteStore.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import Foundation

class QuoteStore: FetchableObject {
    @Published var quote: Quote?
    @Published var author: Character?
    @Published var series: Series?
    
    func clear() {
        phase = .initial
        quote = nil
        author = nil
        series = nil
    }
    
    func setup(series: Series) {
        clear()
        self.series = series
    }
    
    @MainActor
    override func fetchData() async {
        guard let currentSeries = series else {
            phase = .fail(error: "Failed setup")
            return
        }
        
        do {
            guard let currentQuote = try await Quote.getRandom(series: currentSeries) else {
                phase = .fail(error: "Failed fetching quote")
                return
            }
            
            guard let character = try await Character.getCharacter(name: currentQuote.author, series: currentSeries) else {
                phase = .fail(error: "Failed fetching character")
                return
            }
            
            quote = currentQuote
            author = character
            phase = .success
        } catch {
            phase = .fail(error: error.localizedDescription)
        }
    }

}
