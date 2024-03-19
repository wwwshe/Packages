//
//  String+DateFormat.swift
//
//

import Foundation

public extension String {
    /// "."과 "-" replace후 "yyyyMMdd" 또는 "yyMMdd" 포맷으로 리턴
    /// - Returns: string이 포맷이랑 맞지 않을 경우 nil 리턴
    func getDate() -> Date? {
        let value = replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        let dateFormatter = krDateFormatter
        if value.count == 8 {
            dateFormatter.dateFormat = "yyyyMMdd"
        } else if value.count == 6 {
            dateFormatter.dateFormat = "yyMMdd"
        }
        return dateFormatter.date(from: value)
    }

    /// ex: 2024-03-19T15:30:00Z
    var yyyymmddthhmmssZ: Date? {
        let df = krDateFormatter
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df.date(from: self)
    }

    /// ex: 2024-03-19T14:30:00.000+0530
    var yyyymmddthhmmss: Date? {
        let df = krDateFormatter
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return df.date(from: self)
    }
    
    /// ex: 2016-06-23 09:07:21.205-07:00
    var yyyymmddthhmmssDash: Date? {
        let df = krDateFormatter
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-SSSZ"
        return df.date(from: self)
    }
    
    /// ex) "2021-08-17T05:50:18.589Z"
    var yyyymmddthhmmsssssz: Date? {
        // DateFormatter 인스턴스 생성
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return df.date(from: self)
    }

    /// from date format -> to date format 변환
    func changeDateFormat(from: String, to: String) -> String {
        let df = DateFormatter()
        df.dateFormat = from
        if let oldFormDate = df.date(from: self) {
            df.dateFormat = to
            return df.string(from: oldFormDate)
        }
        return self
    }
}
