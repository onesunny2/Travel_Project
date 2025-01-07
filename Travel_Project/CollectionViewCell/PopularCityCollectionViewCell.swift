//
//  PopularCityCollectionViewCell.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/7/25.
//

import UIKit

class PopularCityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    static let identifier = "PopularCityCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cityImageView.image = nil
        cityLabel.text = ""
        explainLabel.text = ""
    }

}
