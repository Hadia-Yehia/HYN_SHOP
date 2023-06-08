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
    
    
   func getAddresses()->[Address]
    {
        let result = `_`()
        var addressesArray:[Address] = []
        for item in result {
            let name = item.value(forKey: "name") as! String
            let surename = item.value(forKey: "surename") as! String
            let phone = item.value(forKey: "phone") as! String
            let country = item.value(forKey: "country") as! String
            let city = item.value(forKey: "city") as! String
            let street = item.value(forKey: "street") as! String
            let area = item.value(forKey: "area") as! String
            let apartment = item.value(forKey: "apartment") as! String
            let floor = item.value(forKey: "floor") as! String
         
            let newAddress = Address(name: name, surname: surename, phone: phone, country: country, city: city, area: area, street: street, apartment: apartment, floor: floor)
   addressesArray.append(newAddress)
 

    }
        return addressesArray
    }
    
    
    func InsertAddress(address: Address) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Addresses")
        fetchRequest.predicate = NSPredicate(format: "phone == %@", address.phone)
        fetchRequest.fetchLimit = 1

        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
               print("address already exists in coreData")
                return
            }

            let entity = NSEntityDescription.entity(forEntityName: "Addresses", in: getContext())!
            let newAddress = NSManagedObject(entity: entity, insertInto: getContext())
            newAddress.setValue(address.name, forKey: "name")
            newAddress.setValue(address.phone, forKey: "phone")
            newAddress.setValue(address.surename, forKey: "surename")
            newAddress.setValue(address.city, forKey: "city")
            newAddress.setValue(address.floor, forKey: "floor")
            newAddress.setValue(address.apartment, forKey: "apartment")
            newAddress.setValue(address.street, forKey: "street")
            newAddress.setValue(address.area, forKey: "area")
            newAddress.setValue(address.country, forKey: "country")

            print("address added successfully")

            try context.save()
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
    }
    
  
    func deleteData(address:Address)
    {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavoriteTeams")
        
        
        do{
            let myPredicate = NSPredicate(format: "address == %addres", address.phone)
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

      
