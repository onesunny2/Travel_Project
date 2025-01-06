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
    
    func searchCity() {
        
        self.placeholder = "가고싶은 나라 및 도시를 입력해주세요."
        self.keyboardType = .default
        self.borderStyle = .roundedRect
        self.clearButtonMode = .whileEditing
    }
}
