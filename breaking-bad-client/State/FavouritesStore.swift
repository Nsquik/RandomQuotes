//
//  FavouritesStore.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/06/2023.
//

import Foundation


class FavouritesStore: FetchableObject {
    @Published var quotes: [FavouriteQuote]?
    
    
    @MainActor
    override func fetchData() async {
        do {
            let result = try Favourites.quotes
            quotes = result
            phase = .success
        }catch {
            phase = .fail(error: error.localizedDescription)
        }
        
    }
    
    @MainActor
    func deleteQuote(_ favourableQuote: any Favourable) {
        do{
            _ = try Favourites.delete(favourable: favourableQuote)
        }catch {
            phase = .fail(error: error.localizedDescription)
        }
        
    }
}


