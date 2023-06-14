//
//  PaymentOptionsViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import Foundation
class PaymentOptionsViewModel{

   
    
    

    func navigateToPayment(coupon:String)-> PaymentViewModel
    {
        return PaymentViewModel(coupon: coupon)
    }
}


