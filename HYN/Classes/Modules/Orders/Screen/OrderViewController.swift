//
//  OrderViewController.swift
//  HYN
//
//  Created by Nada youssef on 07/06/2023.
//

import UIKit
import Lottie
class OrderViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
  
    private var animationView = LottieAnimationView(name: "Loading")

    @IBOutlet weak var orderTable: UITableView!
    var viewModel = OrdersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        orderTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cellOrder")
        orderTable.dataSource = self
        orderTable.delegate = self
       
        // Do any additional setup after loading the view.
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
    func bindViewModel(){
        viewModel.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            DispatchQueue.main.async {
                if isLoading{
                    print("loadingggg")
                    self.animationView.isHidden = false
                    self.animationView.play()
                }else{
                    print("no loadinggg")
                    self.orderTable.reloadData()
                    self.animationView.isHidden = true
                    self.animationView.stop()
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! OrderTableViewCell
        print("orders",viewModel.getCellId(index: indexPath.row))
        cell.configCell(id: viewModel.getCellId(index: indexPath.row), price: viewModel.getCellPrice(index: indexPath.row), date: viewModel.getCellDate(index: indexPath.row))
        /*cell.orderName.text = "shose"
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
    func setUpAnimation(){
        animationView.loopMode = .loop
                animationView.contentMode = .scaleAspectFit
                animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                animationView.center = view.center
                view.addSubview(animationView)
        animationView.isHidden = true
    }

}
