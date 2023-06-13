//
//  CurrencyViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 10/06/2023.
//

import UIKit

class CurrencyViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
let viewModel = CurrencyViewModel()
    @IBAction func selectCurrenyButton(_ sender: UIButton) {
        let selectedRow = currencyPicker.selectedRow(inComponent: 0)
        let selectedCurrency = viewModel.currenciesArray[selectedRow]
        viewModel.changeCurrencyInUserDefaults(newCurrencyCode: selectedCurrency)
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
setupPicker()
        currencyPicker.selectRow(viewModel.selectInitialRow(), inComponent: 0, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        
      //  bindingViewModel()
      //  viewModel.getCurrencyExchange()
        
    }

    func setupPicker()
        {
            currencyPicker.delegate = self
            currencyPicker.dataSource = self
        }
    
    
//    func bindingViewModel()
//    {
//        viewModel.observable.bind {
//            [weak self]
//            result in
//            guard let self = self ,  let isLoading = result
//                    else
//            {
//                return
//            }
//
//            DispatchQueue.main.async {
//                if isLoading
//                {
//                    print("look: \(self.viewModel.currentCurrency)")
//                }
//            }
//
//        }
//    }
    

//    func selectInitialRow() {
//           if let index = viewModel.currenciesArray.firstIndex(of: ) {
//               currencyPicker.selectRow(index, inComponent: 0, animated: false)
//           }
//       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.getCurrenciesArrayCount()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.getCurrency(index: row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let   selectedCurrency = viewModel.getCurrency(index: row)

    }
    
}




