//
//  PaymentOptionsViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import Foundation
class PaymentOptionsViewModel{

   
    var subTotal:Float
    init(subTotal:Float)
    {
        self.subTotal = subTotal
    }
    init()
    {
        subTotal = 0.0
    }

    func navigateToPayment(coupon:String)-> PaymentViewModel
    {
        return PaymentViewModel(coupon: coupon,subTotal: subTotal)
    }
  
}


