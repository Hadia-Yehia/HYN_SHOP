//
//  FavCoreData.swift
//  HYN
//
//  Created by Hadia Yehia on 14/06/2023.
//

import Foundation
import CoreData
import UIKit
class FavCoreData {
    
    static func saveProductToDataBase(item : Fav){
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favourites", in: context)
        let product = NSManagedObject(entity: entity!, insertInto: context)
        product.setValue(item.id, forKey: "id")
        product.setValue(item.img, forKey: "image")
        product.setValue(item.price, forKey: "price")
        product.setValue(item.title, forKey: "title")
        do{
            try context.save()
            print("data added successfully")
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }
    static func fetchProductsFromDataBase()->[Fav]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var array = Array<Fav>()
        var products = Array<NSManagedObject>()
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
        do{
             products = try context.fetch(fetchReq)
            for i in 0..<products.count{
                var obj = Fav(title: "", price: "", img: "", id: 0)
                obj.id =  products[i].value(forKey: "id") as! Int
                obj.img = products[i].value(forKey: "image") as! String
                obj.title = products[i].value(forKey: "title") as! String
                obj.price = products[i].value(forKey: "price") as! String
                print("saved? \(obj.id)  \(obj.title)")
                array.append(obj)
            }
    
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        return array
    }
    static func deleteProduct(id : Int){
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
    static func deleteAllFav(){
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

