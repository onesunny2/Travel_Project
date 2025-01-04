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
        
        tableView.rowHeight = 160
        
    }
    
    // 좋아요 버튼 눌렀을 때, true - false 값 서로 스위칭 되도록
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        // 어떤 버튼이랑 연결되는지 알려줄 필요가 있을 듯. (tag 활용)
        guard let bool = travelInfos.travel[sender.tag].like else { return }

        travelInfos.travel[sender.tag].like = bool ? false : true
 
        /* 🙋🏻‍♀️🙋🏻‍♀️ 질문! 왜 reloadData를 하면 bool 값이 있던 다른 열의 버튼이 사라지거나 버튼이 적용되거나 할까요..? print도 찍어보고 아래에서 tag를 달아주는 순서도 바꿔봤지만 해결하지 못했습니다ㅠㅠ
            ㄴ 검색해보니 재사용셀에서 bool 값의 상태변화 같은 애들의 속성이 뒤섞이는 오류와 함께 delegate 패턴 어쩌고의 이유라고 하는데 맞는 이유일지는.. 이해를 온전히 하지 못해서ㅠㅠ (왠만하면 효율을 위해 reloadRows, insertRows등 사용을 추천)  */
//        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfos.travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = travelInfos.travel[indexPath.row]
        
        // detailInfo 셀
        guard let infoCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoTableViewCell", for: indexPath) as? DetailInfoTableViewCell else { return UITableViewCell() }
        
        // extension 사용 버전1
        /* if let url = row.travel_image {
            infoCell.cityImageView.useKf1(url: url)
        } */
        
        // extension 사용 버전2
        infoCell.cityImageView.useKf2(url: row.travel_image)
        
        /* if row.like == true {
            infoCell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            infoCell.likeButton.setTitle("", for: .normal)
            infoCell.likeButton.tintColor = .red
        } else {
            infoCell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            infoCell.likeButton.setTitle("", for: .normal)
            infoCell.likeButton.tintColor = .red
        } */
        
        if let like = row.like {
            infoCell.likeButton.setImage(UIImage(systemName: like ? "heart.fill" : "heart"), for: .normal)
            infoCell.likeButton.setTitle("", for: .normal)
            infoCell.likeButton.tintColor = .red
//            infoCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        } else {
//            infoCell.likeButton.setImage(UIImage(), for: .normal)
//            infoCell.likeButton.setTitle("", for: .normal)
            
            infoCell.likeButton.isHidden = true
        }
        
        infoCell.likeButton.tag = indexPath.row // 여기서 태그 값 설정해주기
        infoCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        if let title = row.title, let description = row.description {
            infoCell.titleLabel[0].commonUI(title, line: 1, textColor: .label, size: 15, weight: .bold)
            infoCell.titleLabel[1].commonUI(description, line: 0, size: 13)
        } else {
            infoCell.titleLabel[0].text = ""
            infoCell.titleLabel[1].text = ""
        }
        
        if let grade = row.grade {
            let grade = grade.rounded()
            let intGrade = Int(grade)
            for index in 0...intGrade - 1 {
                    infoCell.gradeImageView[index].image = UIImage(named: "star")
                    infoCell.gradeImageView[index].contentMode = .scaleAspectFit
            }
            
            // 위에서 5개를 못채우면 남은 애들 히든 필요해!
            if (5 - intGrade) != 0 && intGrade < 5 {
                // 만약 intGrade = 4 -> index 4 히든
                // 만약 intGrade = 3 -> index 3,4 히든
                for index in intGrade...4 {
                    infoCell.gradeImageView[index].isHidden = true
                }
            }
        }
        
        return infoCell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }

}


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
 
 */
