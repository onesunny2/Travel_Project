//
//  Date+Extension.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/3/25.
//

import Foundation

extension Date {
    
    // 1차로 실패한 내용
    func StringToDate(_ string: String) -> Date? {
        
        let stringDate = string
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyMMdd"
        
        let date = dateformatter.date(from: stringDate)
        
        return date
    }
    
    func DateToString() -> String {

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yy년 MM월 dd일"
        
        return dateformatter.string(from: self)
    }
}
