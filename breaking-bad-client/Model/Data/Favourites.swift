//
//  Favourites.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation
import CoreData


protocol Favourable {
    var id: String {get}
    associatedtype FavourableModel: NSManagedObject
    
    func mapToFavourable(context: NSManagedObjectContext) -> FavourableModel?
}


struct Favourites {
    static var quotes: [FavouriteQuote] {
        get throws {
            let coreDataStack = CoreDataStack<FavouriteQuote>(modelName: "FavouritesModel")
                do {
                    let favouriteQuotes = try coreDataStack.fetchObjects()
                    return favouriteQuotes
                } catch {
                    throw error
                }
        }
    }
    
    
    static func checkIfIsFavourite(favourable: any Favourable) throws -> Bool {
            let coreDataStack = CoreDataStack<FavouriteQuote>(modelName: "FavouritesModel")
            
            do {
                let favouriteObjects = try coreDataStack.fetchObjects { fetchRequest in
                    fetchRequest.predicate = NSPredicate(format: "id == %d", favourable.id)
                }
                
                return !favouriteObjects.isEmpty
            } catch {
                throw error
            }
        }
    
    
    static func saveAsFavourite<T: Favourable>(favourable: T) throws {
            let coreDataStack = CoreDataStack<T.FavourableModel>(modelName: "FavouritesModel")

            
                if let mappedFavourable = favourable.mapToFavourable(context: coreDataStack.getContext())
                {
                    coreDataStack.addObject(mappedFavourable)
                }

        }

}
