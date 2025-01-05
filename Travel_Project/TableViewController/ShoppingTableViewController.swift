//
//  ShoppingTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/5/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var shoppinglists = ShoppingList()

    @IBOutlet var textfieldBgImageView: UIImageView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var shoppingTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldBgImageView.commonUI()
        shoppingTextfield.commonUI()
        textButtonUI()
    }
    
    // text 버튼 디자인
    func textButtonUI() {
        
//        let padding = "  "  >> 버튼은 기본 여백이 있어서 꼼수 없어도 괜찮음
        
        addButton.configuration = .filled()
        addButton.configuration?.title = "추가"
        addButton.configuration?.baseForegroundColor = .label
        addButton.configuration?.baseBackgroundColor = .systemGray5
        addButton.configuration?.buttonSize = .medium
    }
    
    // symbol 버튼 디자인
    func symbolButtonUI(_ button: UIButton, _ bool: Bool, _ trueName: String, _ falseName: String) {
        
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: bool ? trueName : falseName, withConfiguration: symbolConfig), for: .normal)
        button.tintColor = .label
    }

    @IBAction func endOnExitTextfield(_ sender: UITextField) {
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        guard let keyword = shoppingTextfield.text else { return }
        
        // 아무것도 입력하지 않은건 추가를 막고싶을 때
        if keyword.count == 0 {
            
            // 알럿창으로 경고문 띄우기
            let message = UIAlertController(title: "알림", message: "구매하시려는 목록을 다시 확인해주세요!", preferredStyle: .alert)
            let okay = UIAlertAction(title: "확인", style: .cancel)
            message.addAction(okay)
            present(message, animated: true)
            
            view.endEditing(true)
            shoppingTextfield.text = ""
        } else {
            
            let newList = Shopping(keyword: keyword, check: false, favorite: false)
            shoppinglists.shopping.append(newList)
            
            //        tableView.reloadData()
            // 처음에 sender.tag를 이용해봤는데 여기서의 sender는 추가버튼 그 자체였어서.. 총 리스트 갯수의 -1 index에 추가하는걸로
            tableView.insertRows(at: [IndexPath(row: shoppinglists.shopping.count - 1, section: 0)], with: .none)
            
            view.endEditing(true)
            shoppingTextfield.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = shoppinglists.shopping.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = shoppinglists.shopping[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        cell.backgroundImageView.commonUI()
        cell.itemLabel.commonUI(row.keyword, line: 1, textAlignment: .left, textColor: .label, size: 13, weight: .regular)
        
        // 겹치는 요소가 많아서 삼항연산자가 더 간결할 것 같음
        /* if row.check {
            cell.checkboxButton.setTitle("", for: .normal)
            cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            cell.checkboxButton.tintColor = .label
        } else {
            cell.checkboxButton.setTitle("", for: .normal)
            cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            cell.checkboxButton.tintColor = .label
        } */
        
        /* 다시 한번 공통요소 묶어서 줄이기
        cell.checkboxButton.setTitle("", for: .normal)
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        cell.checkboxButton.setImage(UIImage(systemName: row.check ? "checkmark.square.fill" : "checkmark.square", withConfiguration: symbolConfig), for: .normal)
        cell.checkboxButton.tintColor = .label
        
        cell.favoriteButton.setTitle("", for: .normal)
        cell.favoriteButton.setImage(UIImage(systemName: row.favorite ? "star.fill" : "star", withConfiguration: symbolConfig), for: .normal)
        cell.favoriteButton.tintColor = .label */
        
        symbolButtonUI(cell.checkboxButton, row.check, "checkmark.square.fill", "checkmark.square")
        cell.checkboxButton.tag = indexPath.row
        symbolButtonUI(cell.favoriteButton, row.favorite, "star.fill", "star")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

}

/*
    (키워드 추가창 구현)
    - 배경은 아래 셀에도 사용할 공통으로 extension에 구현, 이번엔 cornerRadius에 대해 clip이 아닌 maskToBounds 사용
        ㄴ 둘 다 역할은 똑같이지만 한쪽은 layer 호출 필수
    - 텍스트필드는 좌측 간격은 애초에 스토리보드에서 간격 고려해서 위치 > 따로 조정 필요 없음
    - 기능은 텍스트필드 엔터치면 키보드 내려가게 / 버튼으로만 키워드 추가되도록
 
    (구조체 설정)
    - 아무것도 입력하지 않으면 추가 못하게 할 예정이라 옵셔널 타입 없이 구조 설정
    - 새로 추가되는 키워드는 무조건 체크박스랑 즐겨찾기 false로 초기설정
 
    (셀 디자인 및 데이터)
    - 체크박스랑 즐겨찾기 버튼의 디자인 구성이 동일해서 함수화를 통해 묶는 방법으로 재정리
    - 리스트 추가는 배열에 append한 마지막 순서만 reload 할 수 있도록 해봄 (이게 메모리..?에 더 효율적일 것 같다)
    -
 
 */
