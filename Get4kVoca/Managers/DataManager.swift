//
//  DataManager.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/6/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation

import Foundation
import Sync
import CocoaLumberjackSwift

import CoreData

class DataManager {
    
    private (set) var dataStack: DataStack
    private let modelName: String
    private let storeType: DataStackStoreType
    
    init(modelName: String = "Voca4kWords", storeType: DataStackStoreType = .sqLite) {
        self.modelName = modelName
        self.storeType = storeType
        self.dataStack = DataStack(modelName:modelName, storeType: storeType)
    }
    
    func insertNew<Object: NSManagedObject>(_ type: Object.Type) -> Object {
        let entityName = NSStringFromClass(object_getClass(type)!)
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                               into: dataStack.mainContext) as? Object else {
                                                                fatalError("Could not insert entity \(entityName)")
        }
        return entity
    }
    
    func fetchFirst<Object: NSManagedObject>(_ type: Object.Type, predicate: NSPredicate? = nil) -> Object? {
        var result: Object? = nil
        let request = Object.voca_fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        
        if let objects = try? dataStack.mainContext.fetch(request) as? [Object],
            let object = objects?.first {
            result = object
        }
        
        return result
    }
    
    func deleteObject(_ object: NSManagedObject) {
        dataStack.mainContext.delete(object)
        saveContext()
    }
    
    func saveContext() {
        do {
            try dataStack.mainContext.save()
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
    }
    
    func clearDataBase() {
        dataStack.drop { _ in
            DDLogInfo("Cleared database")
            self.dataStack = DataStack(modelName:self.modelName, storeType: self.storeType)
            DDLogInfo("Reset data stack")
        }
    }
}

extension NSManagedObject {
    
    static func voca_fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: NSStringFromClass(object_getClass(self)!))
    }
    
    static var voca_entityName: String {
        return String(describing: self)
    }
}
