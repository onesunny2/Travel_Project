//
//  InfoNavigationViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/7/25.
//

import UIKit
import Kingfisher

class InfoNavigationViewController: UIViewController {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var popButton: UIButton!
    
    static let identifier = "InfoNavigationViewController"
    
    var contents = [String](repeating: "", count: 3) 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "관광지 화면"
        
        let url = contents[0]
        posterImageView.kf.setImage(with: URL(string: url))
        posterImageView.commonUI(corner: 15, mask: true, color: .clear, opacity: 1, contentMode: .scaleAspectFill)
        titleLabel.commonUI(contents[1], line: 0, textAlignment: .center, textColor: .label, size: 30, weight: .black)
        subtitleLabel.commonUI(contents[2], line: 0, textAlignment: .center, textColor: .label, size: 20, weight: .bold)
        popButton.configuration = .filled()
        popButton.configuration?.cornerStyle = .capsule
        popButton.configuration?.baseForegroundColor = .white
        popButton.configuration?.baseBackgroundColor = .systemIndigo
        popButton.configuration?.attributedTitle = AttributedString("다른 관광지 보러가기", attributes: AttributeContainer().font(.systemFont(ofSize: 15, weight: .medium)))
    }

    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
