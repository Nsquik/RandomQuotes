//
//  DataCoreStack.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation
import CoreData

final class CoreDataStack<Entity: NSManagedObject> {
    private let persistentContainer: NSPersistentContainer

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addObject(_ entity: Entity) {
        let context = persistentContainer.viewContext
        context.insert(entity)
        saveContext()
    }

    
    func fetchObjects(_ modifyFetchRequest: ((NSFetchRequest<Entity>) -> Void)? = nil) throws -> [Entity] {
            let context = persistentContainer.viewContext
            
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
        return persistentContainer.viewContext
    }

}

