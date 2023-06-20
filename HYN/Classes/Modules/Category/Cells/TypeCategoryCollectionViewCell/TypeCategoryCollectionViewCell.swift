//
//  TypeCategoryCollectionViewCell.swift
//  HYN
//
//  Created by Nada youssef on 09/06/2023.
//

import UIKit

class TypeCategoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(img : String,title:String){
        let url = URL(string: img)
        typeImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        typeLabel.text = title
        
    }

}
