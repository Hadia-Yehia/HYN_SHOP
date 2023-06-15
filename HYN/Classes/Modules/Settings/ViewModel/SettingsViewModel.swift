//
//  SettingsViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 15/06/2023.
//

import Foundation
import Firebase
import FirebaseDatabase
class SettingsViewModel{
    var dataSource : [Fav] = Array()
    var lineItemsArray : [LineItems] = Array()
    let defaults = UserDefaults.standard
    var favDraftOrder = DraftOrder()
    var favId: Int?
//    var ref: DatabaseReference = Database.database().reference().child("usersInfo")
    func logout(completionHandler :@escaping(Result<Any,NetworkError>)->Void) {
        print("nfs el ref ?\(self.defaults.object(forKey: "firUserId"))")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.defaults.setValue(false, forKey: "logged in")
            getDataFromDataBase()
         
            favDraftOrder.lineItems = lineItemsArray
            NetworkService.getInstance().postingNewDraftOrder(draftOrder:favDraftOrder , completionHandler: {result in
                switch result{
                case .success(let data):
                    self.favId = data.draftOrder?.id
                    FireBaseSingleTone.getInstance().child(self.defaults.object(forKey: "firUserId") as! String).child("favId").setValue(self.favId)
                    completionHandler(.success("success"))
                    FavCoreData.deleteAllFav()
                    break
                case .failure(.urlError):
                    completionHandler(.failure(.urlError))
                    break
                case .failure(.canNotParseData):
                    break
                }
            })
        
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            completionHandler(.failure(.urlError))
        }
    }
    func getDataFromDataBase(){
        dataSource = FavCoreData.fetchProductsFromDataBase()
        for i in 0..<(dataSource.count) {
            var lineItem = LineItems(title: String(dataSource[i].id) + "*" + dataSource[i].title + "*" + dataSource[i].img, price: dataSource[i].price, quantity: 1)
            lineItemsArray.append(lineItem)
        }
    }
   
}
