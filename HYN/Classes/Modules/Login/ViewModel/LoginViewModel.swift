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
      //  var ref: DatabaseReference = Database.database().reference().child("usersInfo")
        func signIn(email:String,password:String,completionHandler : @escaping(Result<Any, Error>)->Void){
            
                Auth.auth().signIn(withEmail: email, password: password){[weak self] authResult , error in
                    guard let self = self else {return}
                    if let e = error {
                        completionHandler(.failure(e))
                    }
                    else{
                        completionHandler(.success("success"))
                        //username
                        FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/userName").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print("firebase error\(error!.localizedDescription)")
                                return
                            }
                            let userName = snapshot?.value as? String ?? "Unknown"
                            self.defaults.setValue(userName, forKey: "userName")
                        })
                        //userid
                            FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/userId").getData(completion:  { error, snapshot in
                              guard error == nil else {
                                print("firebase error\(error!.localizedDescription)")
                                return
                              }
                               let userId = snapshot?.value as? Int ?? -1
                           self.defaults.setValue(userId, forKey: "userId")
                              
                                print("looky:\(userId)")
                       //firebaseuserid
                            self.defaults.setValue(Auth.auth().currentUser?.uid, forKey: "firUserId")
                        })
                        //favId
                        
                            FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/favId").getData(completion:  { error, snapshot in
                              guard error == nil else {
                                print("firebase error\(error!.localizedDescription)")
                                return
                              }
                               let favId = snapshot?.value as? Int ?? -1
                           self.defaults.setValue(favId, forKey: "favId")
                        })
                        //cartId
                        
                            FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/cartId").getData(completion:  { error, snapshot in
                              guard error == nil else {
                                print("firebase error\(error!.localizedDescription)")
                                return
                              }
                               let cartId = snapshot?.value as? Int ?? -1
                           self.defaults.setValue(cartId, forKey: "cartId")
                        })
                        
                        
                        self.defaults.setValue(true, forKey: "logged in")
                        print(self.defaults.bool(forKey: "logged in"))
                 
                 
                    }
                
            }
        }
    //MARK: getting cart items  from server
    func getDraftCartItems(draftOrderId:Int)
    {
        NetworkService.sharedInstance.getCustomerDraftOrder(draftOrderId: draftOrderId)
        {
            result in
            print(draftOrderId)
            do{
                let array:[LineItems] = try  (result.get().draftOrder?.lineItems) ?? Array()
                for item in array
                {
                    let data = item.title
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
    func getDraftFavoriteItems(draftOrderId:Int)
    {
        NetworkService.sharedInstance.getCustomerDraftOrder(draftOrderId: draftOrderId)
        {
            result in
            do{
                let array:[LineItems] = try  (result.get().draftOrder?.lineItems) ?? Array()
                for item in array
                {
                    let data = item.title
                    let dataComponents:[String] = data.split(separator: "*").map { String($0) }
                    let favoriteItem  = Fav(title: dataComponents[1], price:item.price, img:  dataComponents[2], id: Int(dataComponents[0]) ?? 0)
                    FavCoreData.saveProductToDataBase(item: favoriteItem)
              
                }
            }
            catch
            {
                print("can't get favorite items from server")
            }
        }
    }

    }

