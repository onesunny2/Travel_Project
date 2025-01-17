//
//  PopularNationTableViewCell.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/6/25.
//

import UIKit
import Kingfisher

class PopularNationTableViewCell: UITableViewCell {

    @IBOutlet var cityBackgroundImageView: UIImageView!
    @IBOutlet var labelBackgroundImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 여기서는 항상 고정값인 label의 투명 배경색과 이미지를 덮는 어두운 배경색 설정
        labelBackgroundImageView.commonUI(corner: 20, color: .black, opacity: 0.5)
        labelBackgroundImageView.layer.maskedCorners = CACornerMask.layerMaxXMaxYCorner
        backgroundImageView.commonUI(corner: 20, color: .black, opacity: 0.2)
        backgroundImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
    }
    
    // 이전에 만들어 놓았던 extension들 활용
    func configData(_ row: City) {
        
        let cityName = "\(row.city_name) | \(row.city_english_name)"
        cityLabel.commonUI(cityName, line: 1, textAlignment: .right, textColor: .white, size: 20, weight: .bold)
        
        detailLabel.commonUI(row.city_explain, line: 1, textColor: .white, size: 10, weight: .regular)
        
        guard let url = row.city_image else { return }
        cityBackgroundImageView.commonUI(corner: 20, color: .clear, contentMode: .scaleAspectFill)
        cityBackgroundImageView.kf.setImage(with: URL(string: url))
        cityBackgroundImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
    }
    
    // 셀 재사용
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 비울 데이터들
        cityBackgroundImageView.image = nil
        cityLabel.text = ""
        detailLabel.text = ""
    }
}
