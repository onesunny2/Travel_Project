//
//  InfoPopViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/7/25.
//

import UIKit

class InfoPopViewController: UIViewController {
    
    /*
     ❔질문: adComment에 속성 감시자를 사용했던 이유는 앞에서 값을 받아와서 변하는 주체가 adComment여서 였습니다.
     그런데 자꾸 예상치못한 언랩핑으로 빌드가 터져서 이리저리 해보다가 안되어서, adLabel 아웃렛 쪽에 사용했는데요,
     사용한 이유는 이와 같습니다. [adComment의 값이 변할테니까 adLabel.text = adComment를 하면 adLabel.text의 값도 바뀌어서 속성 감시자가 알아주지 않을까?] 한 의도였는데
     제 의도가 틀리지 않았는지 궁금합니다 + 왜 adComment에서는 안되는걸까요?
     */
    @IBOutlet var adLabel: UILabel! {
        didSet {
            adLabel.text = adComment
        }
    }
    
    var adComment: String?
//    {
//        didSet {
//            print("adComment")
//            adLabel?.text = adComment ?? ""
//        }
//    }
    static let identifier = "InfoPopViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
    }
    
    @objc
    func dismissButtonTapped() {
        dismiss(animated: true)
    }
}
