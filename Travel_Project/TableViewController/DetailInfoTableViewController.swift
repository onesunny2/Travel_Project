//
//  DetailInfoTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/4/25.
//

import UIKit
import Kingfisher

class DetailInfoTableViewController: UITableViewController {
    
    let travelInfos = TravelInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 160

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
    
    - 좋아요 버튼 구현
    
 
 
 */
