//
//  InfoPopViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/7/25.
//

import UIKit

class InfoPopViewController: UIViewController {
    
    @IBOutlet var adLabel: UILabel!
    
    var adCommet: String?
    static var identifier = "InfoPopViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adLabel.text = adCommet
        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
    }
    
    @objc
    func dismissButtonTapped() {
        dismiss(animated: true)
    }
}
