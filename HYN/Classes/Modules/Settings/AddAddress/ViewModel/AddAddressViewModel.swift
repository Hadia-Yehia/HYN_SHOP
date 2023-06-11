//
//  AddAddressViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 09/06/2023.
//

import UIKit

//
//  AddAddressViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddAddressViewModel {
    var addressToBeEdited:Address?
    
    init(address:Address)
    {
        self.addressToBeEdited = address
    }
    init()
    {
        
    }
      var firstName: String?
      var lastName: String?
      var fullName: String?
      var phoneNumber: String?
      var country: String?
      var city: String?
      var address: String?
      var zipCode: String?
   


//    func insertAddressInCoreData(address:testAddress)
//    {
//
//        AddressesCoreData.shared.InsertAddress(address:address)
//    }
//
//    func getAddressesFromCoreData()->[testAddress]
//    {
//        return AddressesCoreData.shared.getAddresses()
//    }
    
    func saveAddress()
    {
        let fullAddress = Address(address1: address!, first_name: firstName!, last_name: lastName!, name: firstName!+lastName!, city: city!, country: country!, phone: phoneNumber!, zip: zipCode!)
        NetworkService.sharedInstance.createNewAddress(address:fullAddress)
        {
            result in
            print("el 7a2e2a: \(result)")
        }
      //  self.insertAddressInCoreData(address: fullAddress)
    }
    
    func checkIfAddressIsNotNil()->Bool
    {
        if addressToBeEdited == nil
        {
            print("")
            return false
        }
        else
        {
            return true
        }
    }
}

