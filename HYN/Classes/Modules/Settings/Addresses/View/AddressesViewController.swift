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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addUIBarButtonItem()
    

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func addUIBarButtonItem()
    {
//        let addAddressButton = UIBarButtonItem(image: UIImage(named: "+"), style: .plain, target: self, action: #selector(navigateToAddAddressView))
//        navigationItem.rightBarButtonItem = addAddressButton
        
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
       2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressTableViewCell
        //cell.configureTeamCell(team: viewModel.getTeam(index: indexPath.row))
        return cell
    }
    
    
}
