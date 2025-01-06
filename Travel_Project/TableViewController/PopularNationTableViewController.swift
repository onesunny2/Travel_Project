//
//  PopularNationTableViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/6/25.
//

import UIKit

/*
 실시간 검색은... 열심히 서치해서 해보았지만... 실패했습니다...
 */

class PopularNationTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var citySegmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    private let searchController = UISearchController()
    
    let segmentTitle = ["모두", "국내", "해외"]
    let cityInfo = CityInfo()
    var city: [City] = []
    
    var isFilterting: Bool {  // 실시간 검색을 하기 위해서는 서치 컨트롤러가 active 상태이고 text 값이 실제로 있는지 알려야 한다고 하는데 적용 안되는 것 같다
        let searchController = self.searchController
        let isActive = searchController.isActive
        let isSearchBarHasText = searchController.searchBar.text?.isEmpty == false
            
            return isActive && isSearchBarHasText
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: PopularNationTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PopularNationTableViewCell.identifier)
        
        searchTextfield.searchCity()
        
        for index in 0...2 {
            citySegmentedControl.setTitle(segmentTitle[index], forSegmentAt: index)
        }
        
        citySegmentedControl.selectedSegmentIndex = 0
        
        city = cityInfo.city  // 초기값 설정
        
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        self.city = cityInfo.city.filter { $0.city_name.contains(text) || $0.city_explain.contains(text) || $0.city_english_name.contains(text) }
        self.tableView.reloadData()
    }
    
    @IBAction func exitTextfield(_ sender: UITextField) {
        
        guard let keyword = sender.text else { return }
        
        // 공백 상태로 엔터치면 원래 리스트 나오도록 구현
        if sender.text?.count == 0 {
            
            let index = citySegmentedControl.selectedSegmentIndex
            
            // segmentcontrol 인덱스 값이 바뀔 때마다 데이터 reload
            switch index {
            case 0:
                city = cityInfo.city
                tableView.reloadData()
            case 1:
                city = cityInfo.city.filter { $0.domestic_travel == true }
                tableView.reloadData()
            case 2:
                city = cityInfo.city.filter { $0.domestic_travel == false }
                tableView.reloadData()
            default:
                break
            }
            
        } else {
            
            city = cityInfo.city.filter { $0.city_name.contains(keyword) || $0.city_english_name.contains(keyword) || $0.city_explain.contains(keyword) }
            
            tableView.reloadData()
        }
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        // segmentcontrol 인덱스 값이 바뀔 때마다 데이터 reload
        switch index {
        case 0:
            city = cityInfo.city
            tableView.reloadData()
        case 1:
            city = cityInfo.city.filter { $0.domestic_travel == true }
            tableView.reloadData()
        case 2:
            city = cityInfo.city.filter { $0.domestic_travel == false }
            tableView.reloadData()
        default:
            break
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let index = citySegmentedControl.selectedSegmentIndex
        
//        switch index {
//        case 0:
//            return cityInfo.city.count
//        case 1:
//            return cityInfo.city.filter { $0.domestic_travel == true }.count
//        case 2:
//            return cityInfo.city.filter { $0.domestic_travel == false }.count
//        default:
//            return 0
//        }
        return city.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let segIndex = citySegmentedControl.selectedSegmentIndex
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularNationTableViewCell.identifier, for: indexPath) as? PopularNationTableViewCell else { return UITableViewCell() }
        
       /* switch segIndex {
        case 0:
//            row = cityInfo.city
//            let row = cityInfo.city[indexPath.row]
            cell.configData(row[indexPath.row])
            
            return cell
        case 1:
            // 처음에 오류났던 이유 => 트루값을 필터링해준게 아니라 그냥 true 이면 전체 셀 중의 indexPath.row 중 참 인 경우만 걸러내서 중간중간
            // 빈 곳이 생겼던 것 (false도 마찬가지)
//            row = cityInfo.city.filter { $0.domestic_travel == true }
            let koreaRow = row[indexPath.row]
            
            cell.configData(koreaRow)
            
            return cell
        case 2:
//            row = cityInfo.city.filter { $0.domestic_travel == false }
            let foreignRow = row[indexPath.row]
            
            cell.configData(foreignRow)
            
            return cell
        default:
            return UITableViewCell()
        } */
        let row = city[indexPath.row]
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
    - 세그먼트 IBAction 연결
    
 
 */
