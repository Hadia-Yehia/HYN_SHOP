//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var wishListTableView: UITableView!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBAction func ordersButton(_ sender: UIButton) {
    }
    @IBOutlet weak var username: UILabel!
    @IBAction func wishListButton(_ sender: UIButton) {
    }
    @IBAction func settingsButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
