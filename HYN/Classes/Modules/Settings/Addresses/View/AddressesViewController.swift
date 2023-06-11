//
//  AddressesViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddressesViewController: UIViewController {

    @IBOutlet weak var noAddressesView: UIView!
    @IBOutlet weak var tableView: UITableView!
   
    let viewModel = AddressesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addUIBarButtonItem()
        checkAddressesTableIfEmpty()
    }
    func checkAddressesTableIfEmpty()
    {
        if viewModel.isAddressesTableEmpty()
        {
            noAddressesView.isHidden = false
            tableView.isHidden = true
        }
        else
        {
            
            noAddressesView.isHidden = true
            tableView.isHidden = false
        }
    }
    
    
    func bindingViewModel()
    {
        viewModel.observable.bind {
            [weak self]
            result in
            guard let self = self ,  let isLoading = result
                    else
            {
                return
            }

            DispatchQueue.main.async {
                if !isLoading
                {
                    self.checkAddressesTableIfEmpty()
                    self.tableView.reloadData()
                }
            }

        }
    }
    override func viewDidAppear(_ animated: Bool) {
        bindingViewModel()
        viewModel.getAddresses()
    
      
  
    }

    func addUIBarButtonItem()
    {

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(navigateToAddAddressView))
    }
    
   @objc func navigateToAddAddressView()
    {
        let destinationViewController = AddAddressViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    func setupTable()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

}



