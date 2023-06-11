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
       // cell.configureCell(address: viewModel.getAddress(index: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addAddressViewController = AddAddressViewController()
        addAddressViewController.viewModel = self.viewModel.editAddress(index: indexPath.row)
        navigationController?.pushViewController(addAddressViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           
           
           let alertController = UIAlertController(title: "Confirmation", message:"Are you sure you want to delete this item?", preferredStyle: .alert)
           
      
           let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
               self.viewModel.deleteAddress(index: indexPath.row)
               self.tableView.deleteRows(at: [indexPath], with: .fade)
               self.checkAddressesTableIfEmpty()
         
           }
           let cancelationAction = UIAlertAction(title: "No", style: .default) { _ in
               return
           }
           
           alertController.addAction(confirmAction)
           alertController.addAction(cancelationAction)
               
           
           if let topController = UIApplication.shared.keyWindow?.rootViewController {
               topController.present(alertController, animated: true, completion: nil)
           }
         
          
       }
   }

    
}

