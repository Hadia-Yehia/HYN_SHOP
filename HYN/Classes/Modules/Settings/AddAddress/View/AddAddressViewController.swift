//
//  AddAddressViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddAddressViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var areaField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var apartementField: UITextField!
    @IBOutlet weak var floorField: UITextField!
    let viewModel = AddAddressViewModel()
    @IBAction func addButton(_ sender: UIButton) {
        let textFields = [nameField, surnameField, phoneNumberField, countryField, cityField, areaField, streetField, apartementField,floorField]

        let allFieldsNonEmpty = !textFields.reduce(false) { $0 || ($1?.text?.isEmpty ?? true) }

        if allFieldsNonEmpty {
          getDataFromTextFields()
            navigationController?.popViewController(animated: true)
        } else {
            Alerts.makeConfirmationDialogue(message: "Please enter all the fields")
        }
    }
    
    func getDataFromTextFields()
    {
        viewModel.name = nameField.text
        viewModel.surname = surnameField.text
        viewModel.phoneNumber = phoneNumberField.text
        viewModel.country = countryField.text
        viewModel.city = cityField.text
        viewModel.area = areaField.text
        viewModel.street = streetField.text
        viewModel.apartment = apartementField.text
        viewModel.floor = floorField.text
        viewModel.saveAddress()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }




}
