//
//  PopularCityViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/7/25.
//

import UIKit

class PopularCityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var citySegmentedControl: UISegmentedControl!
    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    
    let cityInfo = CityInfo()
    var city: [City] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: PopularCityCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: PopularCityCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        citySegmentedControl.setTitle("모두", forSegmentAt: 0)
        citySegmentedControl.setTitle("국내", forSegmentAt: 1)
        citySegmentedControl.setTitle("해외", forSegmentAt: 2)
        citySegmentedControl.selectedSegmentIndex = 0
        
        city = cityInfo.city
        
        textfieldUI()
        
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 28
        let sectionSpacing: CGFloat = 28
        let rowCount: CGFloat = 2
        // 여백으로 길이 계산
        let width: CGFloat = UIScreen.main.bounds.width - (itemSpacing * (rowCount - 1)) - (sectionSpacing * 2)
        let itemWidth: CGFloat = width / rowCount
        // 각 아이템 크기 설정
        layout.itemSize = CGSize(width: itemWidth, height: (itemWidth / 13) * 20)
        layout.scrollDirection = .vertical
        // 상하좌우 여백
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        // 아이템 간 간격 설정
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        
        collectionView.collectionViewLayout = layout
    }
    
    func textfieldUI() {
        searchTextfield.placeholder = "가고싶은 도시를 검색해보세요!"
        searchTextfield.borderStyle = .roundedRect
        searchTextfield.keyboardType = .default
        searchTextfield.clearButtonMode = .whileEditing
        searchTextfield.autocorrectionType = .no
    }
    
    func searchResult(_ sender: UITextField) {
        
        let segIndex = citySegmentedControl.selectedSegmentIndex
        
        guard let keyword = sender.text else { return }
        
        let newKeyword = keyword.lowercased().components(separatedBy: [" "]).joined() // 대소문자와 공백 일괄처리
        
        if segIndex == 0 {
            city = cityInfo.city.filter { $0.city_name.contains(newKeyword) || $0.city_explain.contains(newKeyword) || $0.city_english_name.lowercased().contains(newKeyword) }
            collectionView.reloadData()
        } else if segIndex == 1 {
            city = cityInfo.city.filter { $0.domestic_travel == true && ($0.city_name.contains(newKeyword) || $0.city_explain.contains(newKeyword) || $0.city_english_name.lowercased().contains(newKeyword)) }
            collectionView.reloadData()
        } else if segIndex == 2 {
            city = cityInfo.city.filter { $0.domestic_travel == false && ($0.city_name.contains(newKeyword) || $0.city_explain.contains(newKeyword) || $0.city_english_name.lowercased().contains(newKeyword)) }
            collectionView.reloadData()
        }
    }
    
    @IBAction func enterKeyboardTapped(_ sender: UITextField) {
        searchResult(sender)
    }
    
    @IBAction func editingTextfield(_ sender: UITextField) {
        searchResult(sender)
        
        // 검색하다가 지우면 전체 리스트 보이도록
        if sender.text?.count == 0 {
            segmentValueChanged(citySegmentedControl)
        }
    }
    
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        let index = citySegmentedControl.selectedSegmentIndex
        
        switch index {
        case 0:
            city = cityInfo.city
            collectionView.reloadData()
            print(city.count)
        case 1:
            city = cityInfo.city.filter { $0.domestic_travel == true }
            collectionView.reloadData()
            print(city.count)
        case 2:
            city = cityInfo.city.filter { $0.domestic_travel == false }
            collectionView.reloadData()
            print(city.count)
        default:
            break
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return city.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCityCollectionViewCell.identifier, for: indexPath) as? PopularCityCollectionViewCell else { return UICollectionViewCell() }
        
        let row = city[indexPath.row]
        
        guard let url = row.city_image else { return UICollectionViewCell() }
        
        cell.cityImageView.kf.setImage(with: URL(string: url))
        cell.cityImageView.contentMode = .scaleAspectFill
        cell.cityImageView.layer.cornerRadius = cell.cityImageView.frame.size.width/2
        cell.cityImageView.layer.borderWidth = 1
        cell.cityImageView.layer.borderColor = UIColor.clear.cgColor
        cell.cityImageView.clipsToBounds = true
        
        let title = "\(row.city_name) | \(row.city_english_name)"
        cell.cityLabel.commonUI(title, line: 1, textAlignment: .center, textColor: .label, size: 17, weight: .bold)
        
        cell.explainLabel.commonUI(row.city_explain, line: 0, textAlignment: .center, size: 14, weight: .medium)
        
        return cell
        
    }
    
}


/*
 < 작업 순서 >
 : 파일들 연결, 세그먼트/collectionView의 객체들 각자의 클래스에 아웃렛 연결, collectionView VC에 연결하기
 
 */
