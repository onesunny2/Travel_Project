//
//  UIImageView+Extension.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/4/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    // 옵셔널 바인딩 미포함 버전
    func useKf1(url: String) {
        self.kf.setImage(with: URL(string: url))
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 5
    }
    
    // 옵셔널 바인딩 포함 버전
    func useKf2(url: String?, _ corner: CGFloat = 5) {
        
        guard let url else {
            self.image = UIImage(systemName: "person.fill")
            return
        }
        
        self.kf.setImage(with: URL(string: url))
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = corner
    }
    
    // 일반 배경 처리
    func commonUI(corner: CGFloat = 10, mask: Bool = true) {
        
        self.layer.cornerRadius = corner
        self.layer.masksToBounds = mask
        self.backgroundColor = .systemGray6
    }
}
