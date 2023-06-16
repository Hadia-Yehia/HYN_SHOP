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
    var cartDraftOrder = DraftOrder()
    var cartLineItemsArray : [LineItems] = Array()
    var cartDataSource : [CartItem] = Array()
    var favId: Int?
    var cartId: Int?
//    var ref: DatabaseReference = Database.database().reference().child("usersInfo")
    func logout(completionHandler :@escaping(Result<Any,NetworkError>)->Void) {

        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.defaults.setValue(false, forKey: "logged in")
            getDataFromDataBase()
            getCartDataFromDataBase()
            favDraftOrder.lineItems = lineItemsArray
            cartDraftOrder.lineItems = cartLineItemsArray
            NetworkService.getInstance().postingNewDraftOrder(draftOrder:favDraftOrder , completionHandler: {result in
                switch result{
                case .success(let data):
                    self.favId = data.draftOrder?.id
                    FireBaseSingleTone.getInstance().child(self.defaults.object(forKey: "firUserId") as! String).child("favId").setValue(self.favId)
                    FavCoreData.deleteAllFav()
                    NetworkService.getInstance().postingNewDraftOrder(draftOrder:self.cartDraftOrder , completionHandler: {result in
                        switch result{
                        case .success(let data):
                            self.cartId = data.draftOrder?.id
                            FireBaseSingleTone.getInstance().child(self.defaults.object(forKey: "firUserId") as! String).child("cartId").setValue(self.favId)
                            completionHandler(.success("success"))
                            CartCoreData.shared.deleteALlItems()
                            self.lineItemsArray.removeAll()
                            self.cartLineItemsArray.removeAll()
                            break
                        case .failure(.urlError):
                            completionHandler(.failure(.urlError))
                            break
                        case .failure(.canNotParseData):
                            break
                        }
                    })

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
    func getCartDataFromDataBase(){
        cartDataSource = CartCoreData.shared.getCartItems()
        for i in 0..<(cartDataSource.count) {
            var lineItem = LineItems(title: String(cartDataSource[i].id) + "*" + cartDataSource[i].title + "*" + cartDataSource[i].image, price: String(cartDataSource[i].price), quantity: cartDataSource[i].quantity)
           cartLineItemsArray.append(lineItem)
        }
    }
   
}
