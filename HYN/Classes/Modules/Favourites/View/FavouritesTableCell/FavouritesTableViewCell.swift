//
//  FavouritesTableViewCell.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit
import SDWebImage

class FavouritesTableViewCell: UITableViewCell {

    @IBOutlet weak var removeFromFav: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var favTitle: UILabel!
    
    @IBOutlet weak var favPrice: UILabel!
    @IBOutlet weak var favImg: UIImageView!
    var viewC:UIViewController?
    let viewModel = FavouritesViewModel()
    var table : UITableView?
    var fav : Fav?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(item : Fav,viewC:UIViewController,table:UITableView,index: Int){
        favTitle.text = item.title
        favPrice.text = viewModel.getCurrencyExchange(price: item.price) + (UserDefaults.standard.string(forKey: "currencyCode") ?? "USD")
        self.viewC =  viewC
        self.fav = item
        self.table = table
        favImg.sd_setImage(with: URL(string:item.img), placeholderImage: UIImage(named: "placeholder"))
    }
    
 
    @IBAction func removeFromFav(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.viewModel.deleteItemFromCell(id: self.fav?.id ?? 0)
            self.table?.reloadData()
            if self.viewModel.getTableCount() == 0 {
                self.viewC?.viewDidAppear(true)
            }
        }) )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewC?.present(alert, animated: true, completion: nil)
    }
}
