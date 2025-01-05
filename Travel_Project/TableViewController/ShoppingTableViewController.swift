//
//  ShoppingTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/5/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var textfieldBgImageView: UIImageView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var shoppingTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldBgImageView.commonUI()
        shoppingTextfield.commonUI()
        buttonUI()
    }
    
    // 버튼 디자인
    func buttonUI() {
        
//        let padding = "  "  >> 버튼은 기본 여백이 있어서 꼼수 없어도 괜찮음
        
        addButton.configuration = .filled()
        addButton.configuration?.title = "추가"
        addButton.configuration?.baseForegroundColor = .label
        addButton.configuration?.baseBackgroundColor = .systemGray5
        addButton.configuration?.buttonSize = .medium
    }
    
    @IBAction func endOnExitTextfield(_ sender: UITextField) {
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        shoppingTextfield.text = ""
        
        // 내용 추가부분은 구조체 잡고 하기
    }
    
    

}

/*
    (키워드 추가창 구현)
    - 배경은 아래 셀에도 사용할 공통으로 extension에 구현, 이번엔 cornerRadius에 대해 clip이 아닌 maskToBounds 사용
        ㄴ 둘 다 역할은 똑같이지만 한쪽은 layer 호출 필수
    - 텍스트필드는 좌측 간격은 애초에 스토리보드에서 간격 고려해서 위치 > 따로 조정 필요 없음
    - 기능은 텍스트필드 엔터치면 키보드 내려가게 / 버튼으로만 키워드 추가되도록
 
 */
