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
        print(#function)
        
        textfieldBgImageView.commonUI()
        shoppingTextfield.commonUI()
        textButtonUI()
    }
    
    // text 버튼 디자인
    func textButtonUI() {
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

            tableView.insertRows(at: [IndexPath(row: shoppinglists.shopping.count - 1, section: 0)], with: .none)

            view.endEditing(true)
            shoppingTextfield.text = ""
        }
    }
    
    // 체크박스 변경 함수
    @objc func clickCheckbox(_ button: UIButton) {
        
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        
        if shoppinglists.shopping[button.tag].check {
            button.setImage(UIImage(systemName: "checkmark.square", withConfiguration: symbolConfig), for: .normal)
            shoppinglists.shopping[button.tag].check = false
        } else {
            button.setImage(UIImage(systemName: "checkmark.square.fill", withConfiguration: symbolConfig), for: .normal)
            shoppinglists.shopping[button.tag].check = true
        }
    }
    
    // 즐겨찾기 변경 함수
    @objc func clickFavorite(_ button: UIButton) {
        
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        
        if shoppinglists.shopping[button.tag].favorite {
            button.setImage(UIImage(systemName: "star", withConfiguration: symbolConfig), for: .normal)
            shoppinglists.shopping[button.tag].favorite = false
        } else {
            button.setImage(UIImage(systemName: "star.fill", withConfiguration: symbolConfig), for: .normal)
            shoppinglists.shopping[button.tag].favorite = true
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = shoppinglists.shopping.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = shoppinglists.shopping[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.shopping.rawValue, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        cell.configData(row)
        
        symbolButtonUI(cell.checkboxButton, row.check, "checkmark.square.fill", "checkmark.square")
        symbolButtonUI(cell.favoriteButton, row.favorite, "star.fill", "star")
        cell.checkboxButton.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row

        cell.checkboxButton.addTarget(self, action: #selector(clickCheckbox), for: .touchUpInside)
        cell.favoriteButton.addTarget(self, action: #selector(clickFavorite), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (action, view, completionHandler: @escaping (Bool) -> Void) in
            
            self.shoppinglists.shopping.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
            tableView.reloadData()
            
            completionHandler(true)
        }
        
        delete.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [delete])
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
        ㄴ 특정 열만 reloadrow하는 메서드도 있길래 테스트 >> 기존에 존재한 열을 리로드하는 역할로 앱이 터짐
        ㄴ row 관련된 다른 추가 메서드 있나 확인하다 cellForRow 메서드 실험해봤는데, 기존에 있는 열을 불러오는 기능 발견(언젠가 쓰이겠지)
    - 체크박스와 즐겨찾기 경우의 수 나누어 버튼 클릭 시 액션 구현 완료
        ㄴ 사실 상 둘의 작동방식이 거의 동일하여 1개로 합쳐보기 => 한개로 합치다보니 button 외 설정해야하는 매개변수가 몇개 더 있었고 이는 addTarget에서는 사용 못하는 것 같다..

    (우측 스와이프 액션)
    ** 나의 생각 흐름 : 스와이프 가능한 tableview의 기능 찾아서 -> 현재 내가 지우려는 셀의 indexPath.row를 인식시켜 delete 해서 데이터 리로드 한다
    - trailingSwipeActionsConfigurationForRowAt : 해당 메서드를 사용하면 될 것 같은데 이 메서드의 반환 값인 UISwipeActionsConfiguration은 설명을 보니 대략적으로
      내가 선택한 셀에서 하고싶은 커스텀 액션들의 집합 느낌!
    - UIContextualAction를 통해서 커스텀 액션을 만든다고 한다
 */
