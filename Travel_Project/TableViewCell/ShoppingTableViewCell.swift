//
//  ShoppingTableViewCell.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/5/25.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet var checkboxButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    
    func configData(_ shopping: Shopping) {
        backgroundImageView.commonUI()
        itemLabel.commonUI(shopping.keyword, line: 1, textAlignment: .left, textColor: .label, size: 13, weight: .regular)
    }
}
