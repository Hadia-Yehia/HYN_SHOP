//
//  CartCoreData.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 14/06/2023.
//


import UIKit
import CoreData

class CartCoreData{
    var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    static let shared = CartCoreData()
    
    func getContext() -> NSManagedObjectContext {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    func getEntity()->NSManagedObject{
        
        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: getContext())
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
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        var data : [NSManagedObject] = []
        do{
            data =   try getContext().fetch(fetchReq)
            
        }catch let error as NSError
        {
            print(error.localizedDescription)
        }
       return data
    }
    
    
   func getCartItems()->[CartItem]
    {
        let result = `_`()
        var cartItemsArray:[CartItem] = []
        for item in result {
            let title = item.value(forKey: "title") as! String
            let price = item.value(forKey: "price") as! Float
            let image = item.value(forKey: "image") as! String
            let id = item.value(forKey: "id") as! Int64
            let quantity = item.value(forKey: "quantity") as! Int
            let defaultPrice = item.value(forKey: "defaultPrice") as! Float
            let cartItem = CartItem(id: id, title: title, quantity: quantity, image: image, price: price,defaultPrice: defaultPrice)
            cartItemsArray.append(cartItem)
 

    }
        print("rrrrrr: \(cartItemsArray.count)")
        return cartItemsArray
    }
    
    
    func InsertCartItem(_ cartItem:CartItem) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        fetchRequest.predicate = NSPredicate(format: "id == %d", cartItem.id)
        fetchRequest.fetchLimit = 1

        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
               print("Product already exists in coreData")
                return
            }

            let entity = NSEntityDescription.entity(forEntityName: "Cart", in: getContext())!
            let newCartItem = NSManagedObject(entity: entity, insertInto: getContext())
            newCartItem.setValue(cartItem.id, forKey: "id")
            newCartItem.setValue(cartItem.title, forKey: "title")
            newCartItem.setValue(cartItem.price, forKey: "price")
            newCartItem.setValue(cartItem.quantity, forKey: "quantity")
            newCartItem.setValue(cartItem.image, forKey: "image")
            newCartItem.setValue(cartItem.defaultPrice, forKey: "defaultPrice")
         
           

            print("Product added successfully")

            try context.save()
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
    }
    
  
    func deleteCartItem(_ cartItem:CartItem)
    {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        
        
        do{
            let myPredicate = NSPredicate(format: "id == %lld", cartItem.id)
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
    
    func updateCartItem(_ cartItem:CartItem, operation:String) {
//        var cartItem = cartItem
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        fetchRequest.predicate = NSPredicate(format: "id == %lld", cartItem.id)
        fetchRequest.fetchLimit = 1

        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                let managedObject = results[0] as! NSManagedObject
//                managedObject.setValue(cartItem.id, forKey: "id")
//                managedObject.setValue(cartItem.title, forKey: "title")
//                managedObject.setValue(cartItem.image, forKey: "image")
           
                switch operation
                {
                case "inc":
                    managedObject.setValue(cartItem.quantity+1, forKey: "quantity")
                    managedObject.setValue(cartItem.defaultPrice*Float(cartItem.quantity+1), forKey: "price")
                    
                case "dec":
                    if cartItem.quantity > 1
                    {
                        managedObject.setValue(cartItem.quantity-1, forKey: "quantity")
                        managedObject.setValue(cartItem.defaultPrice*Float(cartItem.quantity-1), forKey: "price")
                    }
                    
                default:
                    return
                }
                self.saveContext()
                print("Item updated successfully")
            } else {
                print("Item not found")
            }
        } catch let error as NSError {
            print("Could not update: \(error), \(error.userInfo)")
        }
    }
    


    
}


      

