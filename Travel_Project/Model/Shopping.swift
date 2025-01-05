//
//  Shopping.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/5/25.
//

import Foundation

struct Shopping {
    let keyword: String
    let check: Bool
    let favorite: Bool
}

struct ShoppingList {
    
    var shopping: [Shopping] = [
        Shopping(keyword: "그립톡 구매하기", check: true, favorite: true),
        Shopping(keyword: "사이다 구매", check: false, favorite: false),
        Shopping(keyword: "핸드폰 케이스 가격 비교해보기", check: false, favorite: true),
        Shopping(keyword: "목도리", check: false, favorite: true)
    ]
}
