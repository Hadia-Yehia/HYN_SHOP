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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(id :Int,price : String,date:String){
        
        priceLabel.text = price
        orderName.text = String(id)
        dataLabel.text = date
    }
    
    func configCellOrder(title :String,price : String,quantity:String){
        
        priceLabel.text = price
        orderName.text = title
        dataLabel.text = quantity
    }
    
}
