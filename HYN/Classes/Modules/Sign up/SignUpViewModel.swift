//
//  SignUpViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 11/06/2023.
//

import Foundation
import Firebase
class SignUpViewModel{
    func rigesterNewCustomer(customer : Customer)->String{
        var res = ""
        Auth.auth().createUser(withEmail: customer.email, password: customer.password){ authResult , error in
            if let e = error{
                print(e)
                res = e.localizedDescription
            }else {
                
                NetworkService.getInstance().postingNewCustomer(customer: CustomerRequest(customer: customer), completionHandler: {result in
                    switch result{
                    case .success(_):
                        res = "success"
                        break
                    case .failure(let error):
                        res = error.localizedDescription
                        break
                    }
                })
            }
        }
        return res
    }
}
