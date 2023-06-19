//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var ordersBtn: UIButton!
    @IBOutlet weak var noItemsInCartView: UIView!
    @IBOutlet weak var wishListTableView: UITableView!
    @IBOutlet weak var ordersTableView: UITableView!
    let viewModel = ProfileViewModel()
    let defaults = UserDefaults.standard
    
    @IBAction func ordersButton(_ sender: UIButton) {
        let orderVC = OrderViewController(nibName: "OrderViewController", bundle: nil)
        navigationController?.pushViewController(orderVC, animated: true)
     
    }

    @IBAction func loginButton(_ sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    @IBAction func wishListButton(_ sender: UIButton) {
        navigationController?.pushViewController(ShoppingCartViewController(), animated: true)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        let destinationViewController = SettingsViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        ordersTableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cellOrder")
        ordersTableView.dataSource = self
        ordersTableView.delegate = self
        
       // self.bindViewModel()
        //viewModel.getOrderData()
checkIfCartHasItems()
checkIfUserLoggedIn()
setupTableView()
loginButton.setRoundedCorners(radius: 10)
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
    
    func checkIfUserLoggedIn()
    {
        if !Availability.isLoggedIn
        {
            welcomeView.isHidden = false
        }
        else
        {
            username.text = UserDefaults.standard.object(forKey: "username") as? String
        }
    }
    func checkIfCartHasItems()
    {
       if viewModel.checkIfCartHasItems()
        {
           wishListTableView.isHidden = false
           noItemsInCartView.isHidden = true
       }
        else
        {
            wishListTableView.isHidden = true
            noItemsInCartView.isHidden = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
     //   bindingViewModel()
        viewModel.getCartItems()
        wishListTableView.reloadData()
        checkIfCartHasItems()
        
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.getCellCount()
//        print("nod",viewModel.getCellCount())
//        //return 2
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! OrderTableViewCell
//        print("^^",viewModel.getCellId(index: indexPath.row))
//        cell.configCell(id: viewModel.getCellId(index: indexPath.row), price: viewModel.getCellPrice(index: indexPath.row), date: viewModel.getCellDate(index: indexPath.row))
//       /* cell.orderName.text = "shose"
//        cell.priceLabel.text = "800"
//        cell.dataLabel.text = "8/9/2023"*/
//        return cell
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func setupTableView()
        {
           wishListTableView.register(UINib(nibName: "ShoppingCartCell", bundle: nil), forCellReuseIdentifier: "Cell")
            wishListTableView.delegate = self
            wishListTableView.dataSource = self
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
//                    wishListTableView.reloadData()
//                }
//            }
//
//        }
//    }


}
extension ProfileViewController:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView
        {
        case wishListTableView:
          return  viewModel.getCartItemsCount()
        default:
            return viewModel.getCellCount()
            
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView
        {
        case wishListTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! ShoppingCartCell
            
//            cell.configCell(viewModel.getCartItem(index: indexPath.row))
//            cell.incrementButton.isHidden = true
//            cell.decrementButton.isHidden = true
//            cell.productQuantity.isHidden = true
//            cell.productImage.contentMode = .scaleAspectFit
    //        cell.incrementButton.tag = indexPath.row
    //        cell.decrementButton.tag = indexPath.row
    //        cell.incrementButton.addTarget(self, action: #selector(inrementProductQuantity(sender:)), for: .touchUpInside)
    //        cell.decrementButton.addTarget(self, action: #selector(decrementProductQuantity(sender:)), for: .touchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! OrderTableViewCell
            print("^^",viewModel.getCellId(index: indexPath.row))
            cell.configCell(id: viewModel.getCellId(index: indexPath.row), price: viewModel.getCellPrice(index: indexPath.row), date: viewModel.getCellDate(index: indexPath.row))
           /* cell.orderName.text = "shose"
            cell.priceLabel.text = "800"
            cell.dataLabel.text = "8/9/2023"*/
            return cell
            
        }
 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return wishListTableView.frame.height/2 -   wishListTableView.frame.height*0.01  }
    
    
    
}
