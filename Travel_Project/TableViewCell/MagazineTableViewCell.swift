//
//  MagazineTableViewCell.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/3/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {

    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var uploadDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        magazineImageView.image = nil
        mainTitleLabel.text = ""
        subTitleLabel.text = ""
        uploadDateLabel.text = ""
    }
    
    func configData(_ magazine: Magazine) {
        magazineImageView.useKf2(url: magazine.photo_image, 10)
        
        mainTitleLabel.commonUI(magazine.title, line: 2, textColor: .label, size: 22, weight: .bold)
        subTitleLabel.commonUI(magazine.subtitle, line: 1, size: 15)
        
        let changeDate = magazine.date.stringToDateToString()
        uploadDateLabel.commonUI(changeDate, line: 1, textAlignment: .right, size: 13)
    }
}
