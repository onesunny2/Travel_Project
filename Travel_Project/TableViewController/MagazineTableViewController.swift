//
//  MagazineTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/3/25.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {
    
    let magazines = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let magazines = MagazineInfo()  -> viewDidLoad에 적으면 이미 실행되고 난 후라 이후 외부에서는 인식 못하는 것 같다!
    }
    
    // 문자열을 날짜로 바꾸는 함수
    func stringToDateToString(_ date: String) -> String {
        
        let uploadDate = date
        
        // 이건 현재 문자열 모양대로의 내용을 날짜로 변환하기 위함
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyMMdd"
        
        // 이건 날짜로 변환한 애를 다시 원하는 형태의 문자열로 만들기 위함
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yy년 MM월 dd일"
        
        
        guard let date = dateFormatter1.date(from: uploadDate) else { return "오류" }
        
        print(date)
        
        let result = dateFormatter2.string(from: date)
        
        return result
    }
    
    func stringToDate(_ date: String) -> Date {
        
        let uploadDate = date
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "yyMMdd"
        
        guard let date = dateformatter.date(from: uploadDate) else { return Date() }
        
        return date
    }
    
    func DateToString(_ date: Date) -> String {
        
        let date = date
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "yy년 MM월 dd일"
        
        let stringDate = dateformatter.string(from: date)  // 문자열의 옵셔널이 나올 수 없음
        
        return stringDate
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as? MagazineTableViewCell else { return UITableViewCell() }
        
        let row = magazines.magazine[indexPath.row]
        
        if let url = row.photo_image {
            cell.magazineImageView.kf.setImage(with: URL(string: url))
        } else {
            cell.magazineImageView.image = UIImage(named: "")
        }
        cell.magazineImageView.contentMode = .scaleAspectFill
        cell.magazineImageView.layer.cornerRadius = 10
        
        cell.mainTitleLabel.commonUI(row.title, line: 2, textColor: .label, size: 22, weight: .bold)
        cell.subTitleLabel.commonUI(row.subtitle, line: 1, size: 15)
        
        // 1) 반환값 있는 함수 사용
//        cell.uploadDateLabel.commonUI(stringToDateToString(row.date), line: 1, textAlignment: .right, size: 13)
        
        // 2) 반환값 없는 함수 사용
       /* let stringToDate = stringToDate(row.date)
        let dateToString = DateToString(stringToDate)
        cell.uploadDateLabel.commonUI(dateToString, line: 1, textAlignment: .right, size: 13) */
        
        // 3) extension 사용 - Date, String 둘 다 사용
        /* let changeDate = row.date.stringToDate()
        let changeString = changeDate.DateToString()
        cell.uploadDateLabel.commonUI(changeString, line: 1, textAlignment: .right, size: 13) */
        
        // 4) extension 사용 - String으로 한번에 사용
        let changeDate = row.date.stringToDateToString()
        cell.uploadDateLabel.commonUI(changeDate, line: 1, textAlignment: .right, size: 13)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

/*
    (고민 포인트)
    1. 이미 구조체에 "YYMMDD"로 나와있는 데이터를 어떻게 DateFormatter를 활용해서 바꿀것인가?
        생각 1) "yyddmm"이라는 문자열 자체를 dateFormatter로 "yy년 mm월 dd일" 로 바꿀 수 있나?
            ㄴ dateFormatter.dateFormat = "yy년 MM월 dd일" >> 이걸로 문자열을 날짜로 변환해서 다시 문자열로 반환했으나... 오류 결과만 나옴
            ㄴ 애초에 구조체에 있는 똑같은 형식인 "yyMMdd" 이렇게 가야하나? >>> ⭕️
        
        생각 2) 1번은 반환값이 있는 함수로 해봤는데, 반환값이 없는 함수로 하면 어떻게 될까?
            ㄴ 반환값 없이 만들다 뭔가 잘 안되어서 생각해보니... 결국 dateFormatter 자체가 날짜를 무언가의 형태로 반환을 해주는거니까
               결과값이 분명히 나오는 것 아닌가.. 라는 결론이 나서 반환값 없는게 아니라 String 변환 / Date 변환 따로 만들어서 사용해보기로 >>> ⭕️
        
        생각 3) 2번에서 만든 함수들을 extension에 넣어보자 (String, Date에)
            ㄴ extension 폴더에 생성 -> ❌ date에는 date를 사용하도록 만들어야하는데, string과 date를 입장 바꿔서 만듦 -> ⭕️
            
        생각 4) 3번을 하고나니 1번도 String으로 반환되니까 extension에 넣어서 사용 가능하지 않을까? -> ⭕️
        
        @@나만의 결론@@
        : 정답은 모르겠지만, 1번과 4번이 조금 더 간편한 것 같다. 사용을 적게해서?
          둘 중에는 controller Class에 코드를 길게 남기고 싶지 않다면 extension으로 빼도 좋을 것 같다는 생각
 */




/*
    (필수구현) 셀 갯수, 셀 디자인 및 데이터연결, 셀 높이(400 정도..?)
 
    (작업순서) 1. 필수구현 함수 기입(완) 2. 더미데이터 연결(완) 3. 필수구현 함수 내용 작성 with 더미데이터
    
    (매거진 - 셀 디자인요소)
    - 구조체는 데이터 유추하여 직접 생성 (O)
    - link 제외 활용 (O)
    - photo는 kingfisher 활용 (O)
    - 날짜는 DateFormatter 활용
 
 
 */
