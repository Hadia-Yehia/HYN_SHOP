//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit

class ProfileViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
   
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var ordersBtn: UIButton!
    @IBOutlet weak var wishListTableView: UITableView!
    @IBOutlet weak var ordersTableView: UITableView!
    var viewModel = ProfileViewModel()
    
    @IBAction func ordersButton(_ sender: UIButton) {
        let orderVC = OrderViewController(nibName: "OrderViewController", bundle: nil)
        navigationController?.pushViewController(orderVC, animated: true)
     
    }
    @IBOutlet weak var username: UILabel!
    @IBAction func wishListButton(_ sender: UIButton) {
        navigationController?.pushViewController(ShoppingCartViewController(), animated: true)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        let destinationViewController = SettingsViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
        //destinationViewController.myProperty = "some value"
       // present(destinationViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        ordersTableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cellOrder")
        ordersTableView.dataSource = self
        ordersTableView.delegate = self
        
       // self.bindViewModel()
        //viewModel.getOrderData()
    }
    func bindViewModel(){
        viewModel.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            DispatchQueue.main.async {
                if isLoading{
                    print("loadingggg")
                }else{
                    print("no loadinggg")
                    self.ordersTableView.reloadData()
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
     if (Availability.isConnectedToInternet){
            self.bindViewModel()
            viewModel.getOrderData()
        }
     else{
            let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellCount()
        print("nod",viewModel.getCellCount())
        //return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! OrderTableViewCell
        print("^^",viewModel.getCellId(index: indexPath.row))
        cell.configCell(id: viewModel.getCellId(index: indexPath.row), price: viewModel.getCellPrice(index: indexPath.row), date: viewModel.getCellDate(index: indexPath.row))
       /* cell.orderName.text = "shose"
        cell.priceLabel.text = "800"
        cell.dataLabel.text = "8/9/2023"*/
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (Availability.isConnectedToInternet){
            let detailsVC = OrderDetailsViewController(nibName: "OrderDetailsViewController", bundle: nil)
            let id = self.viewModel.navigateToOrderDetailsView(index: indexPath.row)
            detailsVC.viewModel = self.viewModel.navigateToOrderDetailsView(index: indexPath.row)
            navigationController?.pushViewController(detailsVC, animated: true)
           }
        else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
