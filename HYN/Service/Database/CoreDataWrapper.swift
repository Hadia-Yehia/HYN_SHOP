//
//  CoreDataWrapper.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

import UIKit
import CoreData

class CoreDataWrapper<T: NSManagedObject> {
    
    let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func getContext() -> NSManagedObjectContext {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    func getEntity() -> T {
        let entityName = String(describing: T.self)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: getContext())!
        let object = T(entity: entity, insertInto: getContext())
        return object
    }
    
    func saveContext() {
        do {
            try getContext().save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchData(predicate: NSPredicate? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        do {
            let objects = try getContext().fetch(request)
            return objects
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func insert(object: T) {
        let objects = fetchData(predicate: NSPredicate(format: "SELF == %@", object))
        if objects.isEmpty {
            getContext().insert(object)
        } else {
            // Update existing object with new values
            let existingObject = objects.first!
            for property in object.entity.properties {
                let newValue = object.value(forKey: property.name)
                existingObject.setValue(newValue, forKey: property.name)
            }
        }
        saveContext()
    }
    
    func delete(object: T) {
        getContext().delete(object)
        saveContext()
    }
    
    func deleteAll() {
        let objects = fetchData()
        for object in objects {
            delete(object: object)
        }
    }
}
