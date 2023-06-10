//
//  OrderTableViewCell.swift
//  HYN
//
//  Created by Nada youssef on 07/06/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var orderName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func removeBtn(_ sender: Any) {
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
