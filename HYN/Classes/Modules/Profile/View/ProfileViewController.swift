//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userName: UILabel!
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
        navigationController?.pushViewController(FavouritesViewController(), animated: true)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        let destinationViewController = SettingsViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.title = "Profile"
       
       
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
            guard  let firstName = UserDefaults.standard.string(forKey: "firstName") , let lastName = UserDefaults.standard.string(forKey: "lastName")
               else {

                   return
               }
     
            self.userName.text = firstName + " " + lastName
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
    
   /* func numberOfSections(in tableView: UITableView) -> Int {
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
    }*/
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
let cell = tableView.dequeueReusableCell(withIdentifier:"FavouritesTableViewCell", for: indexPath) as! FavouritesTableViewCell
            cell.configCell(item: viewModel.getCartItem(index: indexPath.row),viewC: self,table: tableView,index: indexPath.row)
cell.addToCartButton.isHidden = true
cell.removeFromFav.isHidden = true

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


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView
        {
        case wishListTableView:
            break
        default:
           
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
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch tableView
        {
        case wishListTableView:
            return wishListTableView.frame.height/2 -   wishListTableView.frame.height*0.01
        default:
            return wishListTableView.frame.height -   wishListTableView.frame.height*0.01
            
        }
        
    }
    
}
