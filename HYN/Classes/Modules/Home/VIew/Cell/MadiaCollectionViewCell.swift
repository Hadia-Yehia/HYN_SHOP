//
//  MadiaCollectionViewCell.swift
//  HYN
//
//  Created by Nada youssef on 07/06/2023.
//

import UIKit

class MadiaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaView: UIView!
    
    @IBOutlet weak var photoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(img : String){
        let url = URL(string: img)
        photoView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }

}
