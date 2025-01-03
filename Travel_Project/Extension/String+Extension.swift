//
//  String+Extension.swift
//  Travel_Project
//
//  Created by Lee Wonsun on 1/3/25.
//

import Foundation

extension String {
    
    // 1차 실패한 내용
    func DateToString(_ date: Date) -> String {
        
        let inputDate = date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yy년 MM월 dd일"
        
        let date = dateformatter.string(from: inputDate)
        
        return date
    }
    
    // 2차로 작성 내용 (해보니 밖에서 옵셔널 처리 해야해서 번거로우니 여기서 하고 넘어가려고 함!)
    func stringToDate() -> Date {
 
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyMMdd"
        
        guard let resultDate = dateformatter.date(from: self) else { return Date() }
        
        return resultDate
    }
    
    // StringToDateToString 한번에 처리하기
    func stringToDateToString() -> String {

        // 이건 현재 문자열 모양대로의 내용을 날짜로 변환하기 위함
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyMMdd"
        
        // 이건 날짜로 변환한 애를 다시 원하는 형태의 문자열로 만들기 위함
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yy년 MM월 dd일"
        
        
        guard let date = dateFormatter1.date(from: self) else { return "오류" }
 
        let result = dateFormatter2.string(from: date)
        
        return result
    }
}
