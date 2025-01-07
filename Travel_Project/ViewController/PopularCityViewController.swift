//
//  PopularCityViewController.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/7/25.
//

import UIKit

class PopularCityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var citySegmentedControl: UISegmentedControl!
    
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
        
        cell.cityImageView.useKf2(url: row.city_image, 30)
        
        let title = "\(row.city_name) | \(row.city_english_name)"
        cell.cityLabel.commonUI(title, line: 1, textAlignment: .center, textColor: .label, size: 17, weight: .bold)
        
        return cell
        
    }
    
}


/*
 < 작업 순서 >
 : 파일들 연결, 세그먼트/collectionView의 객체들 각자의 클래스에 아웃렛 연결, collectionView VC에 연결하기
 
 */
