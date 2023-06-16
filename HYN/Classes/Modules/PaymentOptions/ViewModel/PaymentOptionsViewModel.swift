//
//  PaymentOptionsViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import Foundation
import PassKit
class PaymentOptionsViewModel{

   
    var subTotal:Float
    var address:Address?

    init(subTotal:Float,address:Address)
    {
        self.subTotal = subTotal
        self.address = address
    }
    init()
    {
        subTotal = 0.0
        address = nil
    }

    func navigateToPayment(coupon:String, isCashSelected:Bool)-> PaymentViewModel
    {
        return PaymentViewModel(coupon: coupon,subTotal: subTotal, address:address!,isCashSelected: isCashSelected)
    }
    func countryCode(for countryName: String) -> String? {
        let locales = Locale.availableIdentifiers
        for localeIdentifier in locales {
            guard let country = Locale(identifier: localeIdentifier).localizedString(forRegionCode: "ZZ") else {
                continue
            }
            if countryName == country {
                return Locale(identifier: localeIdentifier).regionCode
            }
        }
        return nil
    }
  
   
}


