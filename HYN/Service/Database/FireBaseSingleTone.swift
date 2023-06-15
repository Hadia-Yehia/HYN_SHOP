//
//  FireBaseSingleTone.swift
//  HYN
//
//  Created by Hadia Yehia on 15/06/2023.
//

import Foundation
import Firebase
import FirebaseDatabase
class FireBaseSingleTone{
    static let sharedInstance = Database.database().reference().child("usersInfo")
    private init(){}
    static func getInstance() -> DatabaseReference {
        return sharedInstance
    }
}
