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
     제 의도가 틀리지 않았는지 궁금합니다 + 왜 adComment에서는 안되는걸까요? 혹시 viewDidLoad 이전에 adComment의 속성 감시자가 먼저 작동하던데 이게 이유일까요?
     */
    @IBOutlet var adLabel: UILabel! {  // 아웃렛은 view가 로드되면서 viewDidLoad 직전에 호출되는데, 그래서 여기서는 작용하는 것 같습니다.
        didSet {
            print(#function)
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
        
        print(#function)

        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        
        guard let text = adComment else { return }
        adLabel.commonUI(text, line: 0, textAlignment: .center, textColor: .label, size: 24, weight: .black)
    }
    
    @objc
    func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    
}
