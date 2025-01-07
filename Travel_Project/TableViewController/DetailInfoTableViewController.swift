//
//  DetailInfoTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/4/25.
//

import UIKit
import Kingfisher

class DetailInfoTableViewController: UITableViewController {
    
    var travelInfos = TravelInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 좋아요 버튼 눌렀을 때, true - false 값 서로 스위칭 되도록
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        // 어떤 버튼이랑 연결되는지 알려줄 필요가 있을 듯. (tag 활용)
        guard let bool = travelInfos.travel[sender.tag].like else { return }

        travelInfos.travel[sender.tag].like = bool ? false : true
 
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfos.travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = travelInfos.travel[indexPath.row]
        
        if row.ad != true {
            
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: Identifier.travelInfo.rawValue, for: indexPath) as? DetailInfoTableViewCell else { return UITableViewCell() }
            
            infoCell.infoConfigData(row)
            
            infoCell.likeButton.tag = indexPath.row // 여기서 태그 값 설정해주기
            infoCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

            return infoCell
        } else {
            guard let adCell = tableView.dequeueReusableCell(withIdentifier: Identifier.ad.rawValue, for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
            
            adCell.adConfigData(row)

            return adCell
        }
        

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = travelInfos.travel[indexPath.row].ad ? 80 : 160

        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = travelInfos.travel[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if row.ad {
            let adVc = sb.instantiateViewController(withIdentifier: "InfoPopViewController")
            adVc.modalPresentationStyle = .fullScreen
            present(adVc, animated: true)
            
        } else {
            let detailVc = sb.instantiateViewController(withIdentifier: "InfoNavigationViewController")
            navigationController?.pushViewController(detailVc, animated: true)
        }
    }

}


/*
    < 화면전환 >
    1. 관광지셀로 선택해서 push: 어디있는 스토리보드인지, 어떤 뷰컨트롤러 가져올건지, navigationController.pushViewController,
 
 
 */


/*
    (구조체 데이터) - 광고표시를 위해 ad 부분 빼고 다 옵셔널로 타입 선언
    (우선 광고셀 잠시 두고 세부 정보부터 진행)
    - 필수요소: 셀 갯수, 셀 디자인 및 데이터 요소, 셀 높이
        ㄴ 더미 데이터 중 광고셀의 내용도 포함이라서 단순하게 구조체 내부의 count를 한다고 괜찮을지 확인해봐야 할 것 같다
 
    - 첫번째 탭바에 있던 사진 불러오는 것과 내용이 동일해서 extension으로 빼서 한번에 사용하려고 함! (url 작업까지 되려나...?) >> 완료
        ㄴ 추가로 해보고 싶은 것 ) if let 옵셔널 바인딩 작업까지 extension에 포함시켜보자(바인딩 shortened? 사용) >> 예에 성공! (첫번째 탭바도 바꿔보자)
    
    - 좋아요 버튼 UI구현 : 구조체의 like 값이 true 면 빨간하트 아니면 빈하트
        ㄴ 우선 if 조건문으로 구현
        ㄴ 삼항연산자로 바꾸려니 구조체가 nil 값 대응을 위해 옵셔널이어서 바인딩 필요
 
    - 좋아요 버튼 기능 구현
        ㄴ 삼항연산자로 기존 bool이 true면 false 아니면 true가 되도록 시도해봄
        ❔ 왜 데이터를 reloadDate() 했을 땐 다른 열도 바뀌고, reloadRow 했을 땐 정상적일까? 내가 말하는 sender.tag 데이터만 바뀌는 것인데...
            - reloadRow를 했을 때는 해당 열의 데이터만 바뀌니 문제가 없어 보이는데 indexPath.row와 sender.tag값도 연동을 했는데
              왜 자꾸 reloadData()는 다른 열의 버튼이 사라지거나 같이 바뀌거나 하는걸까... print도 찍어보고 코드의 순서도 바꿔보고 했는데 찾지 못함
        ㄴ 그래서 nil 값일 때는 버튼을 아예 hidden 처리 해봤더니 더 깔끔한 것 같다
 
    - 타이틀 구현
        ㄴ 디자인 요소는 이를 고려해 첫번째 탭바에서 만들어두었던 extension 재사용 예정
    
    - 별점 구현
        ㄴ 데이터 속 grade가 소숫점인데 반올림으로 올려서 갯수를 채워볼 예정 -> 총 5개말고 우선은 별 갯수만 맞춰보는걸로
        ㄴ 별 5개가 들어갈 이미지뷰 5개로 저장 label과 함께 stackView로 묶음 => ❔첨에 왜 빈 공간 안줄어들어! 했는데 로직설정을 잘못했었다. 별 갯수를 채우고 남는 애들을 따로 히든 처리 해야한다 => for문 역순으로도 index 셀 수 있을 줄 알았는데 lower bound upper bound 이슈로 터짐!
        ㄴ 이번엔 히든처리 말고 회색 별 진짜 넣어보자ㅏ
 
    - 저장 횟수 구현
        ㄴ 이것도 extension 재사용 해보자! ✅✅ 재사용 연습을 해봐야 공통으로 잘 쓰일 extension을 나중에 더 잘 쓸 수 있을 것 같다
        ㄴ 3자리는 formatted() 전에 배웠던 것 사용!
 
    🔥2개의 셀 도전🔥
    (현재 생각 중인 방법)
        - travelInfo의 ad 값이 true인 indexPath에만 adCell로 바꿔치기 할 수 있다면...?
        1차시도 ) returnCell을 (cell, cell) 2개 반환해보고자 했지만 불가능한 형태로 바로 드랍
        2차시도 ) ad값에 따라서 쓰고자하는 Cell을 넣어보기
            ㄴ 처음에 if 값에 따라서 디자인한 내용을 다 몰아넣었을 때는 제대로 그려지지 않았음
            ㄴ 새로운 cell을 선언해서 그 cell에 infoCell, adCell을 넣어주니 성공!
        
        - 두번째 문제는 각 셀의 높이인데... viewDidLoad에서 if로 나눠서 해주니 설정이 이상함
            ㄴ height 함수로 가보자아
    
    (겪었던 문제상황)
        ✅✅✅ 현재 height를 그대로 사용했을 때 2번탭을 들어가면 앱이 터지는 현상 발견
        - 알고보니 내가 재사용하는 셀을 미리 다 만들어 할당한 후에 ad가 true, false인지에 따라 2개의
          셀을 나눠주면서, 이미 indexPath.row에 중복되도록 2개의 셀이 들어가면서 발생.
        - 처음부터 if문으로 ad의 Bool 값에 따라 조건을 나눠주어 return 하여 해결
        ===> 또 이렇게 애초에 나누다 보니 광고가 없을 때 infoCell에서 nil 값에 대한 else 대응이 없어도 될 것 같음
 */
