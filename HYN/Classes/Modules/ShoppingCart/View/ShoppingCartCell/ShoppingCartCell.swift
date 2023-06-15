//
//  shoppingCartCell.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 06/06/2023.
//

import UIKit

class ShoppingCartCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       setCellStyle(view: view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ cartItem:CartItem)
    {
    //MARK: currency
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
    
        CurrencyManager.exchangePrice(to: currencyCode) {
            exchangeRate in
            let floatValue: Float = cartItem.price * exchangeRate
            let formattedString = String(format: "%.2f", floatValue)
            self.productPrice.text = "\(currencyCode)\(formattedString)"
        }
           
        productImage.sd_setImage(with: URL(string: cartItem.image), placeholderImage: UIImage(named: "placeholder"))
        productPrice.text = String(cartItem.price)
        productQuantity.text = String(cartItem.quantity)
        productTitle.text = cartItem.title
    }
    

        // "EGP\(productPrice * CurrencyManager.exchangePrice(to: "EGP"))"

    
    
   
}
