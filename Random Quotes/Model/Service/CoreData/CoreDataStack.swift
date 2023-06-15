//
//  DataCoreStack.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation
import CoreData

enum CoreDataStackError: Error {
    case deleteError
}


final class CoreDataStack {
    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        
        context = persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addObject<Entity: NSManagedObject>(_ entity: Entity) {
        context.insert(entity)
        saveContext()
    }
    
    func removeObject<Entity: NSManagedObject>(_ entity: Entity) throws {
            context.delete(entity)
            saveContext()
    }
    
    func fetchObjects<Entity: NSManagedObject>(_ modifyFetchRequest: ((NSFetchRequest<Entity>) -> Void)? = nil) throws -> [Entity] {
            guard let entityName = Entity.entity().name else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve entity name."])
            }
            
            let fetchRequest = NSFetchRequest<Entity>(entityName: entityName)
            modifyFetchRequest?(fetchRequest)
            
            
            do {
                let objects = try context.fetch(fetchRequest)
                return objects
            } catch {
                throw error
            }
        }
    
    
    
    
    func getContext() -> NSManagedObjectContext {
        return context
    }

}

