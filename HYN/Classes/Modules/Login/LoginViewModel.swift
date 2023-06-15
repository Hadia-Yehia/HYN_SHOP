//
//  LoginViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 14/06/2023.
//

import Foundation
import Firebase
import FirebaseDatabase
class LoginViewModel{
    let defaults = UserDefaults.standard
    var ref: DatabaseReference = Database.database().reference().child("usersInfo")
    func signIn(email:String,password:String,completionHandler : @escaping(Result<Any, Error>)->Void){
        
            Auth.auth().signIn(withEmail: email, password: password){[weak self] authResult , error in
                guard let self = self else {return}
                if let e = error {
                    completionHandler(.failure(e))
                }
                else{
                    completionHandler(.success("success"))
                    ref.child(Auth.auth().currentUser!.uid).getData(completion:  { error, snapshot in
                      guard error == nil else {
                        print(error!.localizedDescription)
                        return
                      }
                        let userName = snapshot?.value(forKey: "userName") as? String ?? "Unknown"
                        let userId = snapshot?.value(forKey: "userId") as? Int ?? -1
                        let favId = snapshot?.value(forKey: "favId") as? Int ?? -1
                        let cartId = snapshot?.value(forKey: "cartId") as? Int ?? -1
                        self.defaults.setValue(userName, forKey: "userName")
                        self.defaults.setValue(userId, forKey: "userId")
                        self.defaults.setValue(favId, forKey: "favId")
                        self.defaults.setValue(cartId, forKey: "cartId")
                        
                        print(userName)
                    })
                    defaults.setValue(true, forKey: "logged in")
                    print(self.defaults.bool(forKey: "logged in"))
             
                }
            
        }
    }
    //MARK: getting cart items  from server
    func getDraftCartItems(draftOrderId:Int64)
    {
        NetworkService.sharedInstance.getCustomerDraftOrder(draftOrderId: draftOrderId)
        {
            result in
            do{
                let array:[LineItems] = try  (result.get().draftOrder?.lineItems)!
                for item in array
                {
                    let data = "Yousra*Mamdouh*Ali"
                    let dataComponents:[String] = data.split(separator: "*").map { String($0) }
                    let price = Float(item.price)
                    let defaultPrice = (price ?? 0.0) / Float(item.quantity)
                    let cartItem =   CartItem(id: Int64(dataComponents[0]) ?? 0, title: dataComponents[1], quantity: item.quantity, image: dataComponents[2], price: price ?? 0.0, defaultPrice: defaultPrice)
                    CartCoreData.shared.InsertCartItem(cartItem)
        
                }
            }
            catch
            {
                print("can't get cart items from server")
            }
        }
    }
    
    //MARK: getting favorite items  from server
    func getDraftFavoriteItems(draftOrderId:Int64)
    {
        NetworkService.sharedInstance.getCustomerDraftOrder(draftOrderId: draftOrderId)
        {
            result in
            do{
                let array:[LineItems] = try  (result.get().draftOrder?.lineItems)!
                for item in array
                {
                    let data = "Yousra*Mamdouh*Ali"
                    let dataComponents:[String] = data.split(separator: "*").map { String($0) }
                    let favoriteItem  = Fav(title: dataComponents[1], price:item.price, img:  dataComponents[2], id: Int(dataComponents[0]) ?? 0)
                    FavCoreData.saveItemToDataBase(favItem: favoriteItem)
                }
            }
            catch
            {
                print("can't get favorite items from server")
            }
        }
    }

    }

