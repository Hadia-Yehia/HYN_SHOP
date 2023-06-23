//
//  AddressesViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit
import Lottie
class AddressesViewController: UIViewController {

    @IBOutlet weak var noAddressesView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private var animationView = LottieAnimationView(name: "Loading")
    var viewModel = AddressesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        setupTable()
        addUIBarButtonItem()
        noAddressesView.isHidden = true
        //checkAddressesTableIfEmpty()
        if viewModel.subTotal != 0.0
        {
            self.title = "Choose address for purchasing "
        }
    }
    func checkAddressesTableIfEmpty()
    {
        if viewModel.isAddressesTableEmpty()
        {
            noAddressesView.isHidden = false
            tableView.isHidden = true
        }
        else
        {
            
            noAddressesView.isHidden = true
            tableView.isHidden = false
        }
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
                if isLoading{
                    self.animationView.isHidden = false
                    
                    self.animationView.play()
                }
                else
                {
        
                    self.tableView.reloadData()
                    self.animationView.isHidden = true
                    self.animationView.stop()
                    self.checkAddressesTableIfEmpty()
                }
             
            }

        }
    }
    override func viewDidAppear(_ animated: Bool) {
        bindingViewModel()
        viewModel.getAddresses()
    }

    func addUIBarButtonItem()
    {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(navigateToAddAddressView))


        let addButtonImage = UIImage(systemName: "plus.circle.fill")
        let addButton = UIBarButtonItem(image: addButtonImage, style: .done, target: self, action: #selector(navigateToAddAddressView))
        let yellowColor = UIColor(named: "yellow")
        addButton.tintColor = yellowColor
        self.navigationItem.rightBarButtonItem = addButton
    }
    
   @objc func navigateToAddAddressView()
    {
        let destinationViewController = AddAddressViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func setupTable()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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



