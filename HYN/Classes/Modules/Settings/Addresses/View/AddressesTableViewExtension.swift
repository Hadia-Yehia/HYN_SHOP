//
//  AddressesTableViewExtension.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 09/06/2023.
//

import UIKit

extension AddressesViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getAddressesArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressTableViewCell
        cell.configureCell(address: viewModel.getAddress(index: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.subTotal == 0.0
        {
            let addAddressViewController = AddAddressViewController()
            addAddressViewController.viewModel = self.viewModel.editAddress(index: indexPath.row)
            navigationController?.pushViewController(addAddressViewController, animated: true)
        }
        else
        {
           let vC = PaymentOptionsViewController()
            vC.viewModel = self.viewModel.navigateToPaymentOptionsViewModel(index:  indexPath.row)
            navigationController?.pushViewController(vC, animated: true)
            
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           
           
     
           let alertController = Alerts.showAlert(title: "Confirmation", message: "Are you sure you want to delete this item?", confirmTitle: "Yes", cancelTitle: "No", confirmHandler: {
               self.viewModel.deleteAddress(index: indexPath.row)
               {
                   result in
                   if result.0 == "Success"
                   {
                       Alerts.makeConfirmationDialogue(title: result.0, message: result.1)
                   }
                   else
                   {
                       Alerts.makeConfirmationDialogue(title: result.0, message: result.1)
                   }
               }
     //   self.tableView.deleteRows(at: [indexPath], with: .fade)
               self.checkAddressesTableIfEmpty()
           }, cancelHandler: nil)

           if let topController = UIApplication.shared.keyWindow?.rootViewController {
               topController.present(alertController, animated: true, completion: nil)
           }
          
       }
   }

    
}

