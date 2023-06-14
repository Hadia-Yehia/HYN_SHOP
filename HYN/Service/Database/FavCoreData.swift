//
//  FavCoreData.swift
//  HYN
//
//  Created by Hadia Yehia on 14/06/2023.
//

import Foundation
import CoreData
import UIKit
class FavCoreData{

    static func saveItemToDataBase(favItem : Fav){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
         let entity = NSEntityDescription.entity(forEntityName: "Favourites", in: context)
         let fav = NSManagedObject(entity: entity!, insertInto: context)
        fav.setValue(favItem.img, forKey: "image")
        fav.setValue(favItem.price, forKey: "price")
        fav.setValue(favItem.title, forKey: "title")
        fav.setValue(favItem.id, forKey: "id")
        
         do{
             try context.save()
             print("data added successfully")
             
         }catch let error as NSError{
             print(error.localizedDescription)
         }
        
        
  
    }
    static func fetchItems()->[Fav]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var array = Array<Fav>()
        var products = Array<NSManagedObject>()
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
        do{
             products = try context.fetch(fetchReq)
            for i in 0..<products.count{
                var obj = Fav(title: "", price: "", img: "",id: -1)
                obj.id = products[i].value(forKey: "id") as!Int
                obj.img = products[i].value(forKey: "image") as! String
                obj.price = products[i].value(forKey: "price") as! String
                obj.title = products[i].value(forKey: "title") as! String
                print("testtt"+obj.title)
                array.append(obj)
            }
    
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        return array
    }
    static func deleteItem(id : Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var products = Array<NSManagedObject>()
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
        do{
             products = try context.fetch(fetchReq)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        for i in 0..<products.count{
            if products[i].value(forKey: "id") as! Int == id{
                do{
                    context.delete(products[i])
                    try context.save()
                    print("data deleted successfully")
                    
                }catch let error as NSError{
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}
