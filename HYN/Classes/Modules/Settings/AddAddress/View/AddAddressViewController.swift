//
//  AddAddressViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddAddressViewController: UIViewController {
    let countryPickerView = UIPickerView()
    @IBOutlet weak var addAddressButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!

   // @IBOutlet weak var countryField: UITextField!
    
    @IBOutlet weak var countryField: DropDown!
    {
        didSet{
            self.countryField.optionArray = viewModel.allCountries
            self.countryField.selectedRowColor = UIColor(named: "yellow")!
        }

    }
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    var viewModel = AddAddressViewModel()
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButton(_ sender: UIButton) {
        let textFields = [nameField, surnameField, phoneNumberField, countryField, cityField, zipCodeField,addressField]
        let allFieldsNonEmpty = !textFields.reduce(false) { $0 || ($1?.text?.isEmpty ?? true) }

        if allFieldsNonEmpty && validatePhoneNumber() && validateCountry() && validateAddress() && validatePostalCode() && validateFirstName(text: nameField, message: "name") && validateFirstName(text: surnameField, message: "surename") && validateCity() {
          getDataFromTextFields()
            viewModel.saveAddress()
            {
                result in
                if result.0 == "Success"
                {
                    Alerts.makeConfirmationDialogue(title: "Success", message: result.1)
                }
                else
                {
                    Alerts.makeConfirmationDialogue(title: "Failure", message: result.1)
                }
            }
            navigationController?.popViewController(animated: true)
        } else {
            Alerts.makeConfirmationDialogue(title: "Alert", message:  "Please enter all the fields")
        }
    }
    
    func getDataFromTextFields()
    {
        viewModel.fullName = "\(nameField.text ?? "noName") \( surnameField.text ?? "")"
        viewModel.lastName = surnameField.text
        viewModel.firstName = nameField.text
        viewModel.phoneNumber = phoneNumberField.text
        viewModel.country = countryField.text
        viewModel.city = cityField.text
        viewModel.zipCode = zipCodeField.text
        viewModel.address = addressField.text
        
      
    }
    
    func validatePhoneNumber()->Bool
    {
        let regex = try! NSRegularExpression(pattern: #"^\+?[0-9]{1,3}[\s.-]?(\([0-9]{1,4}\)|[0-9]{1,4})[\s.-]?[0-9]{1,4}[\s.-]?[0-9]{1,4}[\s.-]?[0-9]{1,4}$"#)
        let range = NSRange(location: 0, length: phoneNumberField.text?.utf16.count ?? 0)
        
        
        if phoneNumberField.containsNumbersOnly() && regex.firstMatch(in: phoneNumberField.text ?? "0", options: [], range: range) != nil {
        return true
        } else {
            Alerts.makeConfirmationDialogue(title: "Alert", message: "Please enter a valid phone number")
            return false
        }
    }
    func validatePostalCode() -> Bool {
        let regex = try! NSRegularExpression(pattern: #"^\d{5}(?:[-\s]\d{4})?$|^[A-Z0-9]{3}\s?\d{2}$|^\d{4}$|^[A-Z]{2}\s?\d{2}\s?\d{3}$|^\d{6}$|^[A-Z]\d[A-Z]\s?\d[A-Z]\d$|^\d{5}(?:\s*\d{2,3})?$|^[0-9]{4,5}(?:-[0-9]{4})?$|^(\d{5})|(?:^|[^0-9])(?i:1[0-9]{4})($|[^0-9])$"#)
        let range = NSRange(location: 0, length: zipCodeField.text?.utf16.count ?? 0)
        if regex.firstMatch(in: zipCodeField.text ?? "0", options: [], range: range) != nil
        {
            return true
        }
        else
        {
            Alerts.makeConfirmationDialogue(title: "Alert", message: "please enter a valid Postal code")
            return false
        }
    }
    
    func validateFirstName(text:UITextField, message:String) -> Bool {
      
        if text.containsOnlyLetters() && text.text?.count ?? 0 >= 3
        {
            return true
        }
       else
        {
           Alerts.makeConfirmationDialogue(title: "Alert", message: "\(message) must contain only letters at least 3 letters" )
           return false
       }
    }

//    func validateLastName() -> Bool {
//        let regex = try! NSRegularExpression(pattern: #"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"#)
//        let range = NSRange(location: 0, length: surnameField.text?.utf16.count ?? 0)
//        return regex.firstMatch(in: surnameField.text ?? "", options: [], range: range) != nil
//    }
    func setTextFieldsStyle()
    {
        nameField.setBoarder()
        surnameField.setBoarder()
        phoneNumberField.setBoarder()
        zipCodeField.setBoarder()
        cityField.setBoarder()
        countryField.setBoarder()
        addressField.setBoarder()
    }
    func validateCountry()->Bool
    {
        if viewModel.allCountries.contains(countryField.text ?? "")  {
                   return true
                } else {
                    Alerts.makeConfirmationDialogue(title: "Alert", message: "Please choose a valid country")
                    return false
                }
    }
    func validateAddress() -> Bool {
        let address = addressField.text ?? ""
        if address.count >= 12 {
            let whitespaceCount = address.components(separatedBy: .whitespaces).count - 1
            let maxWhitespaceCount = address.count / 2
            if whitespaceCount <= maxWhitespaceCount {
                return true
            } else {
                Alerts.makeConfirmationDialogue(title: "Address not clear!", message: "Too many white spaces")
                return false
            }
        } else {
            Alerts.makeConfirmationDialogue(title: "Address not clear", message: "Please enter at least 12 characters for the address")
            return false
        }
    }
    
    func validateCity()->Bool
    {
        if cityField.containsOnlyLetters() && cityField.text?.count ?? 0 >= 3
        {
            return true
        }
       else
        {
           Alerts.makeConfirmationDialogue(title: "Alert", message: "city must at least contain 3 characters all of them must be letters  " )
           return false
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       checkDestination()
     //   setupCountriesPickerView()
      //  countryField.inputView = countryPickerView
        addAddressButton.setRoundedCorners(radius: 10)
        setTextFieldsStyle()
    }
    
//    func setupCountriesPickerView()
//    {
//        countryPickerView.delegate = self
//        countryPickerView.dataSource = self
//    }

func checkDestination()
    {
       if viewModel.checkIfAddressIsNotNil() == true
        {
           nameField.text = viewModel.addressToBeEdited?.first_name
           surnameField.text = viewModel.addressToBeEdited?.last_name
           phoneNumberField.text = viewModel.addressToBeEdited?.phone
          countryField.text = viewModel.addressToBeEdited?.country
           cityField.text = viewModel.addressToBeEdited?.city
           addressField.text = viewModel.addressToBeEdited?.address1
           zipCodeField.text = viewModel.addressToBeEdited?.zip
          // self.viewModel.editAddress()
           self.title = "Edit Address"
           self.addButton.setTitle("Edit", for:.normal )
           
       }
    }

}
