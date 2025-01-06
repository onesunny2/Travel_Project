//
//  PopularNationTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/6/25.
//

import UIKit

class PopularNationTableViewController: UITableViewController {
    
    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var citySegmentedControl: UISegmentedControl!
    
    let cityInfo = CityInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: PopularNationTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PopularNationTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityInfo.city.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = cityInfo.city[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularNationTableViewCell.identifier, for: indexPath) as? PopularNationTableViewCell else { return UITableViewCell() }
        
        cell.configData(row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }

}



/*
    < 1. 필수 요소 추가 및 XIB Cell 연결하기 >
    - XIB Cell은 viewDidLoad에 등록 절차 거쳐야함 잊지말기
    - cell 디자인은 셀에서 해서 넘김 (세세한 디자인은 기능 끝나면 할 것)
    
    < 2. 세그먼트 내용에 따른 필터링 >
    
 
 */
