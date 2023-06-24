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
    var isLoading : Observable<Bool> = Observable(false)
    var userId : Int?
    var favId : Int?
    var cartId : Int?
    var userName : String = ""
    var res = ""
    var optionalValue: String? = Optional(nil)
    
    let defaults = UserDefaults.standard
    //  var ref: DatabaseReference = Database.database().reference().child("usersInfo")
    func signIn(email:String,password:String,completionHandler : @escaping(Result<Any, Error>)->Void){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        Auth.auth().signIn(withEmail: email, password: password){[weak self] authResult , error in
            guard let self = self else {return}
            if let e = error {
                isLoading.value = false
                completionHandler(.failure(e))
            }
            else{
                gettingDataOnLoggingOn()
                completionHandler(.success("success"))
                
                
            }
            
        }
    }
    func signInWithGoogle(customer : Customer,completionHandler : @escaping(Result<Any, Error>)->Void){
        print("sign in with gog")
        FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/userId").getData(completion:  { error, snapshot in
            if snapshot?.value is Int {
              
                self.gettingDataOnLoggingOn()
            }
           
            else{
                
                print("snap\(String(describing: snapshot?.value))")
                NetworkService.getInstance().postingNewCustomer(customer: CustomerRequest(customer: customer), completionHandler: {result in
                    switch result{
                    case .success(let data):
                        self.userId = data.customer.id
                        guard  let firstName = data.customer.firstName,let lastName = data.customer.lastName
                           else {

                               return
                           }
                        self.res = "success"
                        FireBaseSingleTone.getInstance().child(Auth.auth().currentUser!.uid).setValue(["userId": self.userId,"firstName":firstName,"lastName":lastName,"favId":0,"cartId":0])
                        self.gettingDataOnLoggingOn()
                        completionHandler(.success("success"))
                        break
                    case .failure(let error):
                        self.isLoading.value = false
                        self.res = error.localizedDescription
                        completionHandler(.failure(error))
                        break
                    }
                }
                                                                )
            
        }
            })
    }
    func gettingDataOnLoggingOn(){
        //firstName
        FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/firstName").getData(completion:  { error, snapshot in
            guard error == nil else {
                print("firebase error\(error!.localizedDescription)")
                return
            }
            let firstName = snapshot?.value as? String ?? "Unknown"
            self.defaults.setValue(firstName, forKey: "firstName")
        })
        //lastname
        FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/lastName").getData(completion:  { error, snapshot in
            guard error == nil else {
                print("firebase error\(error!.localizedDescription)")
                return
            }
            let lastName = snapshot?.value as? String ?? "Unknown"
            self.defaults.setValue(lastName, forKey: "lastName")
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
            print("looky fav:\(favId)")
            self.getDraftFavoriteItems(draftOrderId: UserDefaults.standard.object(forKey: "favId") as! Int)
        })
        //cartId
        
        FireBaseSingleTone.getInstance().child("\(Auth.auth().currentUser!.uid)/cartId").getData(completion:  { error, snapshot in
            guard error == nil else {
                print("firebase error\(error!.localizedDescription)")
                return
            }
            let cartId = snapshot?.value as? Int ?? -1
            self.defaults.setValue(cartId, forKey: "cartId")
            print("looky cart:\(cartId)")
            self.getDraftCartItems(draftOrderId:UserDefaults.standard.object(forKey: "cartId") as! Int )
        })

        isLoading.value = false
        self.defaults.setValue(true, forKey: "logged in")
        print(self.defaults.bool(forKey: "logged in"))
        
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
                    let cartItem =   CartItem(id: Int64(dataComponents[0]) ?? 0, title: dataComponents[1], quantity: item.quantity, image: dataComponents[2], price: price ?? 0.0, defaultPrice: defaultPrice,inventoryQuantity: Int(dataComponents[3]) ?? 0)
                    
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
                    let favoriteItem  = Fav(title: dataComponents[1], price:item.price, img:  dataComponents[2], id: Int(dataComponents[0]) ?? 0,inventoryQuantity: Int(dataComponents[3]) ?? 0)
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

