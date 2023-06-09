//
//  Observable.swift
//  SportsHub
//
//  Created by Yousra Mamdouh Ali on 29/05/2023.
//

import UIKit

class Observable<T> {
    private var listener: ((T?)-> Void)?
    var value:  T?
    {
        didSet
        {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
            
        }
    }
    init(_ value: T?) {
        self.value = value
    }

    func bind(_ listener: @escaping ((T?)-> Void))
    {
        listener(value)
        self.listener = listener
    }
 
}
