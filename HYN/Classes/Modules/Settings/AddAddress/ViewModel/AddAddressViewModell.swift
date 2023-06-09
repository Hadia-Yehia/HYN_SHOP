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

    
    var name: String?
      var surname: String?
      var phoneNumber: String?
      var country: String?
      var city: String?
      var area: String?
      var street: String?
      var apartment: String?
      var floor: String?
    
    func insertAddressInCoreData(address:Address)
    {
        
        AddressesCoreData.shared.InsertAddress(address:address)
    }
    
    func getAddressesFromCoreData()->[Address]
    {
        return AddressesCoreData.shared.getAddresses()
    }
    
    func saveAddress()
    {
        let fullAddress = Address(name: name!, surname: surname!, phone: phoneNumber!, country: country!, city: city!, area: area!, street: street!, apartment: apartment!, floor: floor!)
        self.insertAddressInCoreData(address: fullAddress)
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

