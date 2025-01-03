//
//  UILabel+Extension.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/3/25.
//

import UIKit

extension UILabel {
    
    // 왠만하면 다크모드 라이트모드 둘 다 적용되도록 시스템 색상 설정
    func commonUI(_ text: String, line: Int, textAlignment: NSTextAlignment = .left, textColor: UIColor = .systemGray, size: CGFloat, weight: UIFont.Weight = .semibold) {
        
        self.text = text
        self.numberOfLines = line
        self.textAlignment = textAlignment
        self.lineBreakMode = .byWordWrapping
        self.font = .systemFont(ofSize: size, weight: weight)
        self.textColor = textColor
    }
}
