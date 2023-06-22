//
//  SignUpViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 11/06/2023.
//

import Foundation
import Firebase
import FirebaseDatabase

class SignUpViewModel{
    var isLoading : Observable<Bool> = Observable(false)
    let defaults = UserDefaults.standard
    var myCustomer : Customer = Customer(first_name: "", last_name: "", email: "", phone: "", verified_email: false, password: "", password_confirmation: "", send_email_welcome: false)
    var userId : Int?
    var favId : Int?
    var cartId : Int?
    var userName : String = ""
    var email = "unregistered_email"
    var res = ""
    var draftOrder = DraftOrder()
    
    func rigesterNewCustomer(customer : Customer,completionHandler : @escaping(Result<String, Error>)->Void){
        draftOrder.lineItems = [LineItems(title: "base", price: "0", quantity: 1)]
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        Auth.auth().createUser(withEmail: customer.email, password: customer.password){ authResult , error in
            if let e = error{
                print(e)
                self.res = e.localizedDescription
                completionHandler(.failure(e))
            }else {

                        if  ((Auth.auth().currentUser?.isEmailVerified) != nil){
                            NetworkService.getInstance().postingNewCustomer(customer: CustomerRequest(customer: customer), completionHandler: {result in
                                
                                switch result{
                                case .success(let data):
                                    self.userId = data.customer.id
                                    guard  let firstName = data.customer.firstName,let lastName = data.customer.lastName
                                       else {

                                           return
                                       }
                                    self.isLoading.value = false
                                    FireBaseSingleTone.getInstance().child(Auth.auth().currentUser!.uid).setValue(["userId": self.userId,"firstName":firstName,"lastName":lastName,"favId":0,"cartId":0])
                                    //firstname
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
                                    self.res = "success"
                                    completionHandler(.success(self.res))
                                    break
                                case .failure(let error):
                                    self.res = error.localizedDescription
                                    print ("error from model\(self.res)")
                                    completionHandler(.failure(error))
                            
                                    break
                                }
                            }
                            )
                        }else{
                            print("not verified")
                            Auth.auth().currentUser?.delete()
                        }
                    }
                }
            }
        }
//    }
//
//}
