//
//  OrderDetailsViewController.swift
//  HYN
//
//  Created by Nada youssef on 19/06/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
   
    var viewModel : OrderDetailsViewModel?

    @IBOutlet weak var orderId: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var itemstable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemstable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cellOrder")
        itemstable.dataSource = self
        itemstable.delegate = self
        userEmail.text = viewModel?.orderData.contact_email
        orderId.text = viewModel?.orderData.created_at
        totalPrice.text = viewModel?.orderData.current_subtotal_price
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.orderData.line_items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! OrderTableViewCell
        cell.configCellOrder(title: (viewModel?.orderData.line_items[indexPath.row].title)!, price: (viewModel?.orderData.line_items[indexPath.row].price)!, quantity: String((viewModel?.orderData.line_items[indexPath.row].quantity)!))        /*cell.orderName.text = "shose"
        cell.priceLabel.text = "800"
        cell.dataLabel.text = "8/9/2023"*/
        return cell
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
