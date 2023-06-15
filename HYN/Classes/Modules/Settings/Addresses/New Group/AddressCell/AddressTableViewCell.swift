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

    }
    
    func configureCell(address:Address){
    
        fullName.text = address.name
        fullAddress.text = address.address1
        nationality.text = "\(address.city) \(address.country)"
        phone.text = "\(address.phone)"
        
    }
    
  
    
}
