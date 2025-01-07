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
    
    var contents = [String](repeating: "", count: 3) {
        didSet {
            titleLabel.text = contents[1]
            subtitleLabel.text = contents[2]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "관광지 화면"
        
        let url = contents[0]
        posterImageView.kf.setImage(with: URL(string: url))
//        titleLabel.text = contents[1]
//        subtitleLabel.text = contents[2]
    }

    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
