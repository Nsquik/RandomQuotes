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
    
    associatedtype FavouriteModel: NSManagedObject
    func mapToFavourite(context: NSManagedObjectContext) -> FavouriteModel
    func isFavouritePredicate() -> NSPredicate
}

extension Favourable {
    func isFavouritePredicate() -> NSPredicate {
        return NSPredicate(format: "id == %@", self.id)
    }
}


struct Favourites {
    static let coreDataStack = CoreDataStack(modelName: "FavouritesModel")
    
    
    static var quotes: [FavouriteQuote] {
        get throws {
                do {
                    let favouriteQuotes: [FavouriteQuote] = try coreDataStack.fetchObjects()
                    return favouriteQuotes
                } catch {
                    throw error
                }
        }
    }
    
    static func get<T: Favourable>(favourable: T) throws -> T.FavouriteModel? {
            let favouriteObjects: [T.FavouriteModel] = try coreDataStack.fetchObjects { fetchRequest in
                    fetchRequest.predicate = favourable.isFavouritePredicate()
                }
                
            return favouriteObjects.first
        }
    
    static func add<T: Favourable>(favourable: T, addRelations: ((T.FavouriteModel) -> T.FavouriteModel)? = nil) throws -> T.FavouriteModel {
            let favourite = favourable.mapToFavourite(context: coreDataStack.getContext())
            if let addRelations = addRelations {
                let favouriteWithRelations = addRelations(favourite)
                coreDataStack.addObject(favouriteWithRelations)
                return favouriteWithRelations
            } else {
                coreDataStack.addObject(favourite)
                return favourite
            }
        }
    
    static func delete<T: Favourable>(favourable: T) throws -> Bool {
        if let foundFavourite: T.FavouriteModel = try get(favourable: favourable)
        {
            coreDataStack.removeObject(foundFavourite)
            return true
        }
        
        return false
    }
    
    static func update<T: Favourable>(favourable: T, updateFavourite: (_ favouriteEntity: T.FavouriteModel) -> T.FavouriteModel) throws {
        do {
            if let favouriteEntity: T.FavouriteModel = try get(favourable: favourable)
            {
                _ = updateFavourite(favouriteEntity);
                coreDataStack.saveContext()
            }
        } catch {
            throw error
        }
    }
    
    
    static func checkIsFavourite<T: Favourable>(favourable: T) throws -> Bool {
            let foundFavourite: T.FavouriteModel? = try get(favourable: favourable)
            
            return foundFavourite != nil
    }
}
