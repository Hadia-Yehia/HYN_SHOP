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
    var price = ""
    var img = ""
    var id = 0
    var name = ""
    var viewC : UIViewController?
    var valid = true
    @IBOutlet weak var favBtnOutlet: UIButton!
    let viewModel = ProductCollectionViewCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      setCellStyle(view: productView, color: "grey")
    }
    func configCell(img : String,price:String,id:Int,name:String,viewC:UIViewController){
        self.img = img
        self.price = price
        self.id = id
        self.name = name
        self.viewC = viewC
        let url = URL(string: img)
      
        productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        productLabel.text = price
        valid = viewModel.checkValidity(id: id)
        if valid {
            favBtnOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else {
            favBtnOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
            let exchangeRate = CurrencyManager.getRequiredCurrencyExchange()
            let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
            let floatValue: Float = (Float(price) ?? 0.0) * exchangeRate
            let formattedString = String(format: "%.2f", floatValue)
            self.productLabel.text = "\(currencyCode)\(formattedString)"
         
        

           
    }
    func changeCurrencyInCell()
    {
        
    }

    @IBAction func favBtn(_ sender: Any) {
        if Availability.isLoggedIn{
            if  valid {
                viewModel.addToFav(name: name, price: price, img: img, id: id)
                favBtnOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                valid = false
            }
            else{
                let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                    self.viewModel.deleteItemFromCell(id: self.id)
                        self.viewC?.viewDidAppear(true)
                }) )
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                viewC?.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Not Authorized", message: "You should login to add to your favorites?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: {_ in
               let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.viewC?.navigationController?.pushViewController(loginVC, animated: true)
            }) )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            viewC?.present(alert, animated: true, completion: nil)
        }
    }
   
}
