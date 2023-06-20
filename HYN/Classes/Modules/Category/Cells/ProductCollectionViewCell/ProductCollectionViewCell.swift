//
//  ProductCollectionViewCell.swift
//  HYN
//
//  Created by Nada youssef on 09/06/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productView: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      setCellStyle(view: productView, color: "grey")
    }
    func configCell(img : String,price:String,completionHandler:@escaping ()->Void){
        let url = URL(string: img)
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        //productLabel.text = price
        CurrencyManager.exchangePrice(to: currencyCode) {
            exchangeRate in
            let floatValue: Float = (Float(price) ?? 0.0) * exchangeRate
            let formattedString = String(format: "%.2f", floatValue)
            self.productLabel.text = "\(currencyCode)\(formattedString)"
            completionHandler()
        }
           
    }

    @IBAction func favBtn(_ sender: Any) {
    }
}
