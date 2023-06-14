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

    }

