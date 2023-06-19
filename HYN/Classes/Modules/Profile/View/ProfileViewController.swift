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
        let id = UserDefaults.standard.object(forKey: "userId") as? Int
        let orderVC = OrderViewController(nibName: "OrderViewController", bundle: nil)
        navigationController?.pushViewController(orderVC, animated: true)
        NetworkService.gettingOrder(customerID: id!) { (result : Result<OrderRESPONSE,Error>) in
            switch(result){
            case .success(let data):
                print(data.orders)
            case .failure(let error):
                print(error)
            }
            
        }
    }

    @IBAction func loginButton(_ sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    @IBAction func wishListButton(_ sender: UIButton) {
        navigationController?.pushViewController(FavouritesViewController(), animated: true)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        let destinationViewController = SettingsViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfCartHasItems()
    checkIfUserLoggedIn()
        setupTableView()
        loginButton.setRoundedCorners(radius: 10)
      
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
    func setupTableView()
        {
           wishListTableView.register(UINib(nibName: "FavouritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouritesTableViewCell")
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
        viewModel.getCartItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"FavouritesTableViewCell", for: indexPath) as! FavouritesTableViewCell
        cell.configCell(item: viewModel.getCartItem(index: indexPath.row))
        cell.addToCartButton.isHidden = true
        cell.removeFromFav.isHidden = true
//        cell.incrementButton.isHidden = true
//        cell.decrementButton.isHidden = true
//        cell.productQuantity.isHidden = true
        cell.favImg.contentMode = .scaleAspectFit
      //  cell.productImage.contentMode = .scaleAspectFit
//        cell.incrementButton.tag = indexPath.row
//        cell.decrementButton.tag = indexPath.row
//        cell.incrementButton.addTarget(self, action: #selector(inrementProductQuantity(sender:)), for: .touchUpInside)
//        cell.decrementButton.addTarget(self, action: #selector(decrementProductQuantity(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return wishListTableView.frame.height/2 -   wishListTableView.frame.height*0.01  }
    
    
    
}
