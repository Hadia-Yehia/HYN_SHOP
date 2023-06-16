//
//  ProductInfoCollectionViewCell.swift
//  HYN
//
//  Created by Hadia Yehia on 06/06/2023.
//

import UIKit
import SDWebImage

class ProductInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(imgSRC : String){
        let url = URL(string: imgSRC)
        productImg.sd_setImage(with: url, placeholderImage: UIImage(named:"placeholder"))
    }

}
