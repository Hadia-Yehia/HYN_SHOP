//
//  ShoppingCartViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 06/06/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    var isArrowUp = false
    @IBOutlet weak var moreDetailsButton: UIButton!
    @IBOutlet weak var checkoutDetailsView: UIView!
    @IBAction func checkoutButton(_ sender: UIButton) {
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.setRoundedCorners(radius: 5)
        showMoreDetailsButton()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showMoreDetailsButton()
    {
        // Create a button to represent the arrow
    
       moreDetailsButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        moreDetailsButton.tintColor = .black
        moreDetailsButton.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        checkoutDetailsView.isHidden = true
      
    }
    @objc func arrowButtonTapped() {
        // Toggle the arrow direction and animate the arrow button
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

}
