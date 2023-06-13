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
    }
    func configCell(img : String,price:String){
        let url = URL(string: img)
        productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        productLabel.text = price
    }

    @IBAction func favBtn(_ sender: Any) {
    }
}
