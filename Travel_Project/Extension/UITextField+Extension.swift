//
//  UITextField+Extension.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/5/25.
//

import UIKit

extension UITextField {
    
    func commonUI() {
        
        self.placeholder = "구매하실 목록을 추가해주세요 :)"
        self.keyboardType = .default
        self.returnKeyType = .done
        self.borderStyle = .none
        self.clearButtonMode = .whileEditing
    }
}
