//
//  Model.swift
//  Ios test
//
//  Created by Гарик on 15.10.2022.
//

import Foundation
import CoreData

struct Products: Decodable {
    var products: [DataTask]
}

struct DataTask: Decodable {
    var sort: Int
    var name: String
    var product: String
    var description: String?
    var price: String
    var image: String
}

class CoreDataFoodTest {
    
    lazy var resultController: NSFetchedResultsController <Foods> = {
        let request = Foods.fetchRequest()
        let sort = NSSortDescriptor(key: "sort", ascending: true)
        request.sortDescriptors = [sort]
        let resultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return resultController
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Ios_test")
        return container
    }()
    
    init() {
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                do {
                    try self.resultController.performFetch()
                } catch {
                    print(error)
                }
            }
        })
    }
}

