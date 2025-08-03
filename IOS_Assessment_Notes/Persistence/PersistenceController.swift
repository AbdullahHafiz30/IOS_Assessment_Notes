//
//  PersistenceController.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 01/08/2025.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    static let inMemory: PersistenceController = {
        PersistenceController(inMemory: true)
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url =
                URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error { fatalError("Core-Data load failed: \(error)") }
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

