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
    
    let segmentTitle = ["모두", "국내", "해외"]
    let cityInfo = CityInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: PopularNationTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PopularNationTableViewCell.identifier)
        
        searchTextfield.searchCity()
        
        for index in 0...2 {
            citySegmentedControl.setTitle(segmentTitle[index], forSegmentAt: index)
        }
        
        citySegmentedControl.selectedSegmentIndex = 0
        
    }
    
    @IBAction func searchTextfield(_ sender: UITextField) {
        
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        // segmentcontrol 인덱스 값이 바뀔 때마다 데이터 reload
        switch index {
        case 0:
            tableView.reloadData()
        case 1:
            tableView.reloadData()
        case 2:
            tableView.reloadData()
        default:
            break
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let index = citySegmentedControl.selectedSegmentIndex
        
        switch index {
        case 0:
            return cityInfo.city.count
        case 1:
            return cityInfo.city.filter { $0.domestic_travel == true }.count
        case 2:
            return cityInfo.city.filter { $0.domestic_travel == false }.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let segIndex = citySegmentedControl.selectedSegmentIndex
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularNationTableViewCell.identifier, for: indexPath) as? PopularNationTableViewCell else { return UITableViewCell() }
        
        switch segIndex {
        case 0:
            let row = cityInfo.city[indexPath.row]
            cell.configData(row)
            
            return cell
        case 1:
            // 처음에 오류났던 이유 => 트루값을 필터링해준게 아니라 그냥 true 이면 전체 셀 중의 indexPath.row 중 참 인 경우만 걸러내서 중간중간
            // 빈 곳이 생겼던 것 (false도 마찬가지)
            let korea = cityInfo.city.filter { $0.domestic_travel == true }
            let koreaRow = korea[indexPath.row]
            
            cell.configData(koreaRow)
            
            return cell
        case 2:
            let foreign = cityInfo.city.filter { $0.domestic_travel == false }
            let foreignRow = foreign[indexPath.row]
            
            cell.configData(foreignRow)
            
            return cell
        default:
            return UITableViewCell()
        }

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
    - 세그먼트 IBAction 연결
    
 
 */
