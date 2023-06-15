//
//  ShoppingCartViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 06/06/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    var isArrowUp = false
    let viewModel = ShoppingCartViewModel()
    @IBOutlet weak var noItemsView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBAction func moreDetailsButton(_ sender: UIButton) {
        isArrowUp.toggle()
        let imageName = isArrowUp ? "chevron.up" : "chevron.down"
        UIView.animate(withDuration: 0.25) {
            self.moreDetailsButton.transform = CGAffineTransform(rotationAngle: self.isArrowUp ? .pi : 0)
            self.moreDetailsButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        // Animate the reveal view
        UIView.animate(withDuration: 0.25) {
            self.checkoutDetailsView.isHidden = !self.isArrowUp
            self.checkoutDetailsView.frame.origin.y = self.isArrowUp ? self.view.bounds.height - self.checkoutDetailsView.bounds.height : self.view.bounds.height
        }
        
    }
    @IBOutlet weak var moreDetailsButton: UIButton!
    @IBOutlet weak var checkoutDetailsView: UIView!
    @IBAction func checkoutButton(_ sender: UIButton) {
        navigationController?.pushViewController(PaymentOptionsViewController(), animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.setRoundedCorners(radius: 5)
        showMoreDetailsButton()
        setupTableView()
        checkCartTableIfEmpty()
        self.title = "Shopping Cart"
    
       
    }
    override func viewWillAppear(_ animated: Bool) {
        bindingViewModel()
        viewModel.getCartItemsFromCoreData()
    }

func setupTableView()
    {
        tableView.register(UINib(nibName: "ShoppingCartCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
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
                if isLoading
                {
                    self.checkCartTableIfEmpty()
                    self.tableView.reloadData()
                    self.totalPrice.text = self.viewModel.newCurrency
                }
            }

        }
    }
    func checkCartTableIfEmpty()
    {
        if viewModel.isCartItemArrayEmpty()
        {
            noItemsView.isHidden = false
            tableView.isHidden = true
        }
        else
        {
            
           noItemsView.isHidden = true
            tableView.isHidden = false
        }
    }

    
    func showMoreDetailsButton()
    {
        // Create a button to represent the arrow
    
       moreDetailsButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        moreDetailsButton.tintColor = .black
      //  moreDetailsButton.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        checkoutDetailsView.isHidden = true
      
    }
    @objc func arrowButtonTapped() {
        // Toggle the arrow direction and animate the arrow button

    }
    
    

}

extension ShoppingCartViewController:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCartItemArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! ShoppingCartCell
        cell.configCell(viewModel.getCartItem(index: indexPath.row))
        cell.incrementButton.tag = indexPath.row
        cell.decrementButton.tag = indexPath.row
        cell.incrementButton.addTarget(self, action: #selector(inrementProductQuantity(sender:)), for: .touchUpInside)
        cell.decrementButton.addTarget(self, action: #selector(decrementProductQuantity(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func inrementProductQuantity(sender:UIButton)
        {
            viewModel.incrementCartItemQuantity(at: sender.tag)
        }
        
        @objc func decrementProductQuantity(sender:UIButton)
        {
            viewModel.decrementCartItemQuantity(at: sender.tag)
        }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           
           
           let alertController = Alerts.showAlert(title: "Confirmation", message: "Are you sure you want to delete this item?", confirmTitle: "Yes", cancelTitle: "No", confirmHandler: {
               self.viewModel.deleteCartItem(index: indexPath.row)
               self.tableView.deleteRows(at: [indexPath], with: .fade)
               self.viewModel.getCartItemsFromCoreData()
               self.checkCartTableIfEmpty()
           }, cancelHandler: nil)

           if let topController = UIApplication.shared.keyWindow?.rootViewController {
               topController.present(alertController, animated: true, completion: nil)
           }
         
          
       }
   }
    
}
