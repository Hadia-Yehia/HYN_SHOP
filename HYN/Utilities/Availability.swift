//
//  Connectivity.swift
//  HYN
//
//  Created by Hadia Yehia on 16/06/2023.
//

import Foundation
import Alamofire
class Availability {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    class var isLoggedIn:Bool{
        return UserDefaults.standard.bool(forKey: "logged in")
    }
}
