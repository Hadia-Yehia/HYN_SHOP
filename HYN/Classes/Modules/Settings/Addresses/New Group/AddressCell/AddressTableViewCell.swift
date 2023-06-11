//
//  AddressTableViewCell.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var fullAddress: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellStyle(view: view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(address:Address)
    {
        print("el idyyyy :\(address.id)")
        fullName.text = "\(address.first_name) \(address.last_name)"
        fullAddress.text = address.address1
        nationality.text = "\(address.city) \(address.country)"
        phone.text = "\(address.phone)"
        
    }
    
    func setCellStyle(view:UIView)
       {
           //view.layer.borderColor = UIColor(named: "#48BFBE")?.cgColor
         // view.layer.borderColor = UIColor.red.cgColor
           let customColor = UIColor(named: "grey")
           view.layer.borderColor = customColor?.cgColor
           view.layer.borderWidth = 0.7
          view.layer.cornerRadius = 20
       }
    
}
