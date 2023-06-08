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
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
    }
    
}
