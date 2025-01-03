//
//  MagazineTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/3/25.
//

import UIKit

class MagazineTableViewController: UITableViewController {
    
    let magazines = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let magazines = MagazineInfo()  -> viewDidLoad에 적으면 이미 실행되고 난 후라 이후 외부에서는 인식 못하는 것 같다!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as? MagazineTableViewCell else { return UITableViewCell() }
        
//        cell.megazineImageView
        
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

/*
    (필수구현) 셀 갯수, 셀 디자인 및 데이터연결, 셀 높이(400 정도..?)
 
    (작업순서) 1. 필수구현 함수 기입(완) 2. 더미데이터 연결(완) 3. 필수구현 함수 내용 작성 with 더미데이터
    
    (셀 디자인요소)
    -
 
 
 */
