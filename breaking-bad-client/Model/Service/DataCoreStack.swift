//
//  DataCoreStack.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//

import Foundation
import CoreData

//final class CoreDataStack {
//    private let persistentContainer: NSPersistentContainer
//
//    init(modelName: String) {
//        persistentContainer = NSPersistentContainer(name: modelName)
//        persistentContainer.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Failed to load persistent stores: \(error)")
//            }
//        }
//    }
//
//    func saveContext() {
//        let context = persistentContainer.viewContext
//
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    func fetchQuotes() -> [Quote] {
//        let context = persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quote")
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            let quotes = results.compactMap { result -> Quote? in
//                guard let quote = result as? QuoteEntity else {
//                    return nil
//                }
//
//                return Quote(id: quote.id, content: quote.content, author: quote.author, isFavourite: quote.isFavourite)
//            }
//
//            return quotes
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//
//    func markQuoteAsFavourite(_ quote: Quote) {
//        let context = persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quote")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", quote.id)
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            guard let quoteEntity = results.first as? QuoteEntity else {
//                return
//            }
//
//            quoteEntity.isFavourite = true
//
//            saveContext()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
