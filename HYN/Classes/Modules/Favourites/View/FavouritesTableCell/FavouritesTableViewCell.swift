//
//  FavouritesTableViewCell.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit
import SDWebImage

class FavouritesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var favTitle: UILabel!
    
    @IBOutlet weak var favPrice: UILabel!
    @IBOutlet weak var favImg: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(item : Fav){
        favTitle.text = item.title
        favPrice.text = item.price
        favImg.sd_setImage(with: URL(string:item.img), placeholderImage: UIImage(named: "placeholder"))
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
    }
    @IBAction func removeFromFav(_ sender: UIButton) {
    }
}
