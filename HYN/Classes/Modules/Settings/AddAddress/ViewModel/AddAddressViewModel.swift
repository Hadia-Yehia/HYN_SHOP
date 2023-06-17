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
    var observable: Observable <Bool> = Observable(false)
    let allCountries = Locale.isoRegionCodes.map { (code) -> String in
        let identifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return Locale(identifier: "en_US_POSIX").localizedString(forIdentifier: identifier) ?? "Unknown"
    }
    var selectedCountry: String?
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
    func saveAddress(completionHandler: @escaping ((String,String)) -> Void)
    {
       
        let fullAddress = Address(address1: address!, first_name: firstName!, last_name: lastName!, name: fullName!, city: city!, country: country!, phone: phoneNumber!, zip: zipCode!)
        if checkIfAddressIsNotNil() == true {
         
            NetworkService.sharedInstance.updateCustomerAddress(addressId: addressToBeEdited?.id ?? 0, address: fullAddress)
            {
                result in
                switch result {
                    case .success(let customerAddress):
                        completionHandler(("Success","Address added Successfully"))
                        print("New address created: \(customerAddress)")
                    case .failure(let error):
                    completionHandler(("Failure","\(error.localizedDescription)"))
                        print("Error creating new address: \(error)")
                    }
            }
        }
        else
        {
            NetworkService.sharedInstance.createNewAddress(address:fullAddress)
            {
                result in
                switch result {
                    case .success(let customerAddress):
                    completionHandler(("Success","Address added Successfully"))
                        print("New address created: \(customerAddress)")
                    case .failure(let error):
                    completionHandler(("Failure","\(error.localizedDescription)"))
                        print("Error creating new address: \(error)")
                    }
            }
        }
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

