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
  
    let allCountries = Locale.isoRegionCodes.map { (code) -> String in
        let identifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return Locale(identifier: "en_US_POSIX").localizedString(forIdentifier: identifier) ?? "Unknown"
    }
    var firstName: String?
    var lastName: String?
    var fullName: String?
    var phoneNumber: String?
    var country: String?
    var city: String?
    var address: String?
    var zipCode: String?
    
    var addressToBeEdited:Address?
    
    init(address:Address)
    {
        self.addressToBeEdited = address
    }
    init()
    {
        
    }
  
   


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
//    
    func saveAddress()
    {
       
        let fullAddress = Address(address1: address!, first_name: firstName!, last_name: lastName!, name: fullName!, city: city!, country: country!, phone: phoneNumber!, zip: zipCode!)
        if checkIfAddressIsNotNil() == true {
         
            NetworkService.sharedInstance.updateCustomerAddress(addressId: addressToBeEdited?.id ?? 0, address: fullAddress)
            {
                reslt in
    
                print("loooky:\(self.addressToBeEdited?.id ?? 0)")
                
            }
        }
        else
        {
            NetworkService.sharedInstance.createNewAddress(address:fullAddress)
            {
                result in
            }
        }
      //  self.insertAddressInCoreData(address: fullAddress)
    }

    
    func checkIfAddressIsNotNil()->Bool
    {
        if addressToBeEdited == nil
        {
            return false
        }
        else
        {
            return true
        }
    }
    
//MARK: Countries Picker View
    
    func getNuberOfCountries()->Int{
     return   allCountries.count
    }
    
    func getCountry(index:Int)->String
    {
        allCountries[index]
    }
}

