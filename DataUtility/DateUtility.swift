//
//  DateUtility.swift
//
//
//  Created by jun wook on 2023/07/15.
//

import Foundation

/// 날짜 관련 유틸리티
public struct DateUtility {
    let dateFormatter = DateFormatter()

    public init() {}

    /// "yyyy-MM-dd'T'HH:mm:ssZ"
    public func stringToDateISO(string: String) -> Date {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string) ?? Date()
    }

    /// "yyyy년 MM월 dd일 HH:mm"
    public func dateToString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        return dateFormatter.string(from: date)
    }
}
