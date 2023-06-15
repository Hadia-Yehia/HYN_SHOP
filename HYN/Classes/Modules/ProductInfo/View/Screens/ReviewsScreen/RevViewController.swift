//
//  RevViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 15/06/2023.
//

import UIKit

class RevViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
let viewModel = ReviewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        revTable.dataSource = self
        revTable.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
    revTable.register(UINib(nibName: "ReviewTableViewCell", bundle: nil),forCellReuseIdentifier: "ReviewTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var revTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        cell.configCell(review: viewModel.getObjectForCell(index: indexPath.row))
        return cell
    }

}
