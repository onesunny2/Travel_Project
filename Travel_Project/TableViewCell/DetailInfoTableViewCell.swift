//
//  DetailInfoTableViewCell.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/4/25.
//

import UIKit

class  DetailInfoTableViewCell: UITableViewCell {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var gradeImageView: [UIImageView]!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel[0].text = ""
        titleLabel[1].text = ""
        for index in 0...4 {
            gradeImageView[index].image = nil
        }
        saveLabel.text = ""
        likeButton.setImage(nil, for: .normal)
    }
    
    func infoConfigData(_ info: Travel) {
        cityImageView.useKf2(url: info.travel_image)
                
        if let like = info.like {
            likeButton.setImage(UIImage(systemName: like ? "heart.fill" : "heart"), for: .normal)
            likeButton.setTitle("", for: .normal)
            likeButton.tintColor = .red
        }
        
        if let title = info.title, let description = info.description {
            titleLabel[0].commonUI(title, line: 1, textColor: .label, size: 15, weight: .bold)
            titleLabel[1].commonUI(description, line: 0, size: 13)
        }
        
        if let grade = info.grade {
            let grade = grade.rounded()
            let intGrade = Int(grade)
            for index in 0...intGrade - 1 {
                    gradeImageView[index].image = UIImage(named: "star")
                    gradeImageView[index].contentMode = .scaleAspectFit
            }
            
            // 위에서 5개를 못채우면 남은 애들 히든 필요해!
            if (5 - intGrade) != 0 && intGrade < 5 {
                
                for index in intGrade...4 {
                    gradeImageView[index].image = UIImage(named: "graystar")
                }
            }
        }
        
        if let save = info.save {
            let formatted = save.formatted()
            saveLabel.commonUI("• 저장 \(formatted)", line: 1, textColor: .systemGray2, size: 12)
        }

    }
}

