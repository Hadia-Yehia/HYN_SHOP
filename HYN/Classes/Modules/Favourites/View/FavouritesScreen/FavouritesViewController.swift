//
//  FavouritesViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit

class FavouritesViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var favTable: UITableView!
    @IBOutlet weak var noFavView: UIView!
    let viewModel = FavouritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        favTable.register(UINib(nibName: "FavouritesTableViewCell", bundle: nil),forCellReuseIdentifier: "FavouritesTableViewCell")
        favTable.dataSource = self
        favTable.delegate = self
        self.title = "Favourites"

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getFav()
        favTable.reloadData()
        noFavView.isHidden = true
        notAuthorizedView.isHidden = true
        if Availability.isLoggedIn{
            if viewModel.getTableCount() == 0 {
                self.noFavView.isHidden = false
            }
        }
        else{
            notAuthorizedView.isHidden = false
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableCount()
    }
    
  
    @IBOutlet weak var notAuthorizedView: UIView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as! FavouritesTableViewCell
        cell.configCell(item: viewModel.getObjectForCell(index: indexPath.row))
        cell.addToCartButton.addTarget(self, action: #selector(addProductToCart(sender:)), for: .touchUpInside)
//        cell.removeFromFav.addTarget(self, action: #selector(removeFromFav(sender:)), for: .touchUpInside)
        return cell    }
    
    @objc func addProductToCart(sender:UIButton)
        {
            viewModel.insertProductInCoreData(at: sender.tag)
            {
                result in
                if result
                {
                    Toast.show(message: "Product added to cart successfully", controller: self)
                }
                else
                {
                    Toast.show(message: "Product already exists in cart", controller: self)
                }
            }
       
        }
//    @objc func removeFromFav(sender:UIButton)
//        {
//
//            let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete?", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
//                self.viewModel.deleteItem(index:sender.tag)
//                self.favTable.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
//                if self.viewModel.getTableCount() == 0 {
//                    self.viewDidAppear(true)
//                }
//            }) )
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            self.present(alert, animated: true, completion: nil)
//        }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.viewModel.deleteItem(index:indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if self.viewModel.getTableCount() == 0 {
                    self.viewDidAppear(true)
                }
            }) )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true, completion: nil)
       
                
            
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Availability.isConnectedToInternet{
            let productInfoVC = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
            productInfoVC.viewModel = self.viewModel.navigateToDetailsScreen(index: indexPath.row)
            self.navigationController?.pushViewController(productInfoVC, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
         
        }
    

    @IBAction func loginBtn(_ sender: UIButton) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    @IBAction func startExploringBtn(_ sender: UIButton) {
    }
}
   

