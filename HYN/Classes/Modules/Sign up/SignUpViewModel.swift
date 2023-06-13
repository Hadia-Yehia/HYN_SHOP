//
//  SignUpViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 11/06/2023.
//

import Foundation
//import Firebase
//import FirebaseDatabase
//
//class SignUpViewModel{
//    var userId : Int?
//    var email = "unregistered_email"
//    var ref: DatabaseReference = Database.database().reference().child("usersInfo")
//    func rigesterNewCustomer(customer : Customer)->String{
//        var res = ""
//        
//        Auth.auth().createUser(withEmail: customer.email, password: customer.password){ authResult , error in
//            if let e = error{
//                print(e)
//                res = e.localizedDescription
//            }else {
//                
//                NetworkService.getInstance().postingNewCustomer(customer: CustomerRequest(customer: customer), completionHandler: {result in
//                    switch result{
//                    case .success(let data):
//                        self.userId = data.customer.id
//                        if let email = data.customer.email{
//                            self.email = email}
//                        self.ref.child(Auth.auth().currentUser!.uid).setValue(["userId": self.userId])
//                        res = "success"
//                        break
//                    case .failure(let error):
//                        res = error.localizedDescription
//                        break
//                    }
//                })
//            }
//        }
//        return res
//    }
//}
