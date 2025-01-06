//
//  AdTableViewCell.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/4/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var badgeLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var backgroundColorImageView: UIImageView!
    
    var adColor: [UIColor] = [.systemMint, .systemCyan, .orange, .yellow, .systemGray, .green]
    
    func adConfigData(_ info: Travel) {
        backgroundColorImageView.layer.cornerRadius = 10
        backgroundColorImageView.clipsToBounds = true
        backgroundColorImageView.backgroundColor = adColor.randomElement()
        
        if let title = info.title {
            adLabel.commonUI(title, line: 2, textAlignment: .center, textColor: .label, size: 14, weight: .bold)
        }
          
        let spacing = "  "
        badgeLabel.commonUI(" AD\(spacing)", line: 1, textAlignment: .center, textColor: .label, size: 13, weight: .medium)
        badgeLabel.layer.cornerRadius = 5
        badgeLabel.clipsToBounds = true
        badgeLabel.backgroundColor = .white
    }
}
