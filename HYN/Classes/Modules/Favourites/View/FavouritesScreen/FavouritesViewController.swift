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

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getFav()
        favTable.reloadData()
        if viewModel.getTableCount() > 0{
            print(viewModel.getTableCount())
            noFavView.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as! FavouritesTableViewCell
        cell.configCell(item: viewModel.getObjectForCell(index: indexPath.row))
        return cell    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.viewModel.deleteItem(index:indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if self.viewModel.getTableCount() == 0 {
                    self.loadView()
                }
            }) )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true, completion: nil)
       
                
            
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let productInfoVC = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
            productInfoVC.viewModel = self.viewModel.navigateToDetailsScreen(index: indexPath.row)
            self.navigationController?.pushViewController(productInfoVC, animated: true)
        }
    


    @IBAction func startExploringBtn(_ sender: UIButton) {
    }
}
   

