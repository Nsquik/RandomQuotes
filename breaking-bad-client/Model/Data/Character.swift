//
//  Character.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 03/05/2023.
//

import Foundation
import CoreData

struct Character: Favourable {
    let id: String
    let name: String
    let image: URL
    
    static func getCharacter(name: String, source: any CharacterSource) async throws -> Character? {
        return try await source.getCharacter(name: name)
    }
    
    typealias FavouriteModel = FavouriteCharacter
    func mapToFavourite(context: NSManagedObjectContext) -> FavouriteCharacter {
        let favouriteCharacter = FavouriteCharacter(context: context)
        favouriteCharacter.id = self.id
        favouriteCharacter.name = self.name
        favouriteCharacter.image = self.image.absoluteString
        return favouriteCharacter
    }
}

