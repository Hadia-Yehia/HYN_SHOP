//
//  AddressesCoreData.swift
//  SportsHub
//
//  Created by Yousra Mamdouh Ali on 8/06/2023.
//

import UIKit
import CoreData

class AddressesCoreData{
    var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    static let shared = AddressesCoreData()
    
    func getContext() -> NSManagedObjectContext {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    func getEntity()->NSManagedObject{
        
        let entity = NSEntityDescription.entity(forEntityName: "Addresses", in: getContext())
        let teams = NSManagedObject(entity: entity!, insertInto: getContext())
        return teams;
    }
    
    func saveContext()
    {
        do{
            try getContext().save()
            
        }catch let error as NSError{
            print(error.localizedDescription)
            
        }
    }
    
    private func `_`()->  [NSManagedObject]
    {
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Addresses")
        var data : [NSManagedObject] = []
        do{
            data =   try getContext().fetch(fetchReq)
            
        }catch let error as NSError
        {
            print(error.localizedDescription)
        }
       return data
    }
    
    
   func getDataFromCoreData()->[Address]
    {
        let result = `_`()
        var addressesArray:[Address] = []
        for item in result {
            let fullName = item.value(forKey: "fullName") as! String
            let address = item.value(forKey: "address") as! String
            let phone = item.value(forKey: "phone") as! String
            let nationality = item.value(forKey: "nationality") as! String
            let floor = item.value(forKey: "floor") as! String
         
            let newAddress = Address(address: address, nationality: nationality, fullName: fullName, phone: phone,floor: floor)
   addressesArray.append(newAddress)
 

    }
        return addressesArray
    }
    
    
    func InsertTeamInDatabase(address: Address) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Addresses")
        fetchRequest.predicate = NSPredicate(format: "address == %@", address.address)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
               print("address already exists in coreData")
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: "Addresses", in: getContext())!
            let newAddress = NSManagedObject(entity: entity, insertInto: getContext())
            newAddress.setValue(address.fullName, forKey: "fullName")
            newAddress.setValue(address.phone, forKey: "phone")
            newAddress.setValue(address.nationality, forKey: "nationality")
            newAddress.setValue(address.address, forKey: "address")
            newAddress.setValue(address.floor, forKey: "floor")
            
            print("address added successfully")
            
            try context.save()
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
    }
    func deleteDataFromDatabase(address:Address)
    {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavoriteTeams")
        
        
        do{
            let myPredicate = NSPredicate(format: "address == %addres", address.address)
            fetchReq.predicate = myPredicate
         let addresses =   try context.fetch(fetchReq)
            for address in addresses
            {
                context.delete(address)
                self.saveContext()
    
            }
            
        }catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    
   
}

      
