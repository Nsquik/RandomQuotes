//
//  FavouritesStore.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 02/06/2023.
//

import Foundation


class FavouritesStore: FetchableObject {
    @Published var breakingBadQuotes: [FavouriteQuote] = []
    @Published var betterCallSaulQuotes: [FavouriteQuote] = []
    @Published var gameOfThronesQuotes: [FavouriteQuote] = []
    
    @Published var quotes: [Series: [FavouriteQuote]] = [:]
    
    
    
    
    @MainActor
    override func fetchData() async {
        do {
            let result = try Favourites.quotes
            
            breakingBadQuotes = result.filter { $0.series == Series.breakingBad.getFullName() }
            betterCallSaulQuotes = result.filter { $0.series == Series.betterCallSaul.getFullName() }
            gameOfThronesQuotes = result.filter { $0.series == Series.gameOfThrones.getFullName() }
            
            phase = .success
        }catch {
            phase = .fail(error: error.localizedDescription)
        }
    }

    func deleteQuote(_ indexSet: IndexSet, series: Series) {
        guard let indexToDelete = indexSet.first else {
            return
        }

        do {
            var quotes: [FavouriteQuote]?
            
            switch series {
                case .breakingBad:
                    quotes = breakingBadQuotes
                case .betterCallSaul:
                    quotes = betterCallSaulQuotes
                case .gameOfThrones:
                    quotes = gameOfThronesQuotes
            }

            guard indexToDelete < quotes?.count ?? 0 else {
                return
            }

            if let quoteToDelete = quotes?[indexToDelete] {
                _ = try Favourites.delete(favourite: quoteToDelete)
            }

            switch series {
                case .breakingBad:
                    breakingBadQuotes.remove(at: indexToDelete)
                case .betterCallSaul:
                    betterCallSaulQuotes.remove(at: indexToDelete)
                case .gameOfThrones:
                    gameOfThronesQuotes.remove(at: indexToDelete)
            }
        } catch {
            phase = .fail(error: error.localizedDescription)
        }
    }

}


