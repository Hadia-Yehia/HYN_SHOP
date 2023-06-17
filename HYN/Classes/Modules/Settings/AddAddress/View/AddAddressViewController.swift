//
//  AddAddressViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddAddressViewController: UIViewController {
    let countryPickerView = UIPickerView()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!

    @IBOutlet weak var countryField: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    var viewModel = AddAddressViewModel()
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButton(_ sender: UIButton) {
        let textFields = [nameField, surnameField, phoneNumberField, countryField, cityField, zipCodeField,addressField]
        let allFieldsNonEmpty = !textFields.reduce(false) { $0 || ($1?.text?.isEmpty ?? true) }

        if allFieldsNonEmpty && validatePhoneNumberAndZipCode(){
          getDataFromTextFields()
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
        viewModel.saveAddress()
    }
    
    func validatePhoneNumberAndZipCode()->Bool
    {
        if phoneNumberField.containsNumbersOnly() && zipCodeField.containsNumbersOnly() {
        return true
        } else {
            Alerts.makeConfirmationDialogue(title: "Alert", message: "Phone number and zip code should contain numbers only!")
            return false
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
       checkDestination()
        setupCountriesPickerView()
        countryField.inputView = countryPickerView
        
    
    }
    
    func setupCountriesPickerView()
    {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
    }

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
