//
//  QuoteStore.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import Foundation

class DataStore<TDataSource: DataSource>: FetchableObject {
    @Published var quote: Quote<TDataSource>?
    @Published var author: Character<TDataSource>?
    @Published var series = TDataSource.series
    

    func clear() {
        phase = .initial
        quote = nil
        author = nil
    }

    @MainActor
    override func fetchData() async {
        do {
            guard let fetchedQuote = try await Quote<TDataSource>.random else {
                phase = .fail(error: "Failed fetching quote")
                return
            }
            
//            guard let fetchedCharacter = try await Character<TDataSource>.getCharacter(name: fetchedQuote.author) else {
//                phase = .fail(error: "Failed fetching character")
//                return
//            }
            
            print(fetchedQuote)
            quote = fetchedQuote
//            author = fetchedCharacter
            phase = .success
        } catch {
            print(error)
            phase = .fail(error: error.localizedDescription)
        }
    }

}
