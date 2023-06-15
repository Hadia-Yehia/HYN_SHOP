//
//  Coomon.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 06/06/2023.
//

import UIKit

extension UIButton {
    func setRoundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
extension UIView
{
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
