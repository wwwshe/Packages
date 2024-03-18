//
//  Date+Extension.swift
//
//

import Foundation

public extension Date {
    var yyMMddHHmmss: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yy.MM.dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }

    var yyyyMMddHHmmss: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }

    var yyyyMMddHHmm: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        return dateFormatter.string(from: self)
    }

    var hypheFormatyyyyMMddHHmm: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: self)
    }

    var yyyyMMdd: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }

    var yyMMdd: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }

    var MMdd: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"
        return dateFormatter.string(from: self)
    }

    var MMddHHmmss: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "MM.dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }

    var HHmmss: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }

    var yyyyMMddDash: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return "\(dateFormatter.string(from: self))"
    }

    var yyMMddHHmmssDash: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }

    var yyyyMMddHHmmssDash: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }

    var yyyMMddDashUTC: String {
        let dateFormatter = enDateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return "\(dateFormatter.string(from: self))"
    }

    var yyyyMMddKrwString: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 EEEE"
        return "\(dateFormatter.string(from: self))"
    }

    var MMddString: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "MM월 dd일"
        return "\(dateFormatter.string(from: self))"
    }

    var HHmm: String {
        let dateFormatter = krDateFormatter
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }

    // 오늘과의 날짜 차이 24시간 기준아님
    // 오늘이면 0
    // 어제면 -1
    var dayDiffToday: Int? {
        let interval = firstTimeOfDay.timeIntervalSince(Date().firstTimeOfDay)
        let days = Int(interval / (60 * 60 * 24))
        return days
    }

    // 오늘과의 날짜 차이 24시간 기준(TAPP-2125)
    // 오늘이면 0
    // 어제면 -1
    var dayDiffNowWithTime: Int? {
        let interval = timeIntervalSince(Date())
        let days = Int(interval / (60 * 60 * 24))
        return days
    }

    // 만 날짜 차이 24시간끼리 잘라낸후 남으면 +1일을 해줘야했다 ㅠㅠ
    var dayDiffTime: Int? {
        let interval = timeIntervalSince(Date())
        let remind = Int(interval) % Int(60 * 60 * 24)
        let days = Int(interval / (60 * 60 * 24)) + (remind > 0 ? 1 : 0)
        return days
    }

    func dayDiff(_ date: Date) -> Int? {
        let interval = date.firstTimeOfDay.timeIntervalSince(firstTimeOfDay)
        let days = Int(interval / (60 * 60 * 24))
        return days
    }

    var relativePast: String {
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
        let components = Calendar.current.dateComponents(units, from: self, to: Date())

        if components.year! > 0 ||
            components.month! > 0 ||
            components.weekOfYear! > 0 ||
            components.day! > 1
        {
            let dateFormatter = krDateFormatter
            dateFormatter.dateFormat = "yy.MM.dd HH:mm:ss"
            return dateFormatter.string(from: self)

        } else if components.day! == 1 {
            return "어제"

        } else if components.hour! > 0 {
            return "\(components.hour!) " + "시간 전"

        } else if components.minute! > 0 {
            return "\(components.minute!) " + "분 전"
        } else {
            return "방금전"
        }
    }

    var lastThreeDay: Date {
        return Calendar.current.date(byAdding: .day, value: -3, to: self)!
    }

    var lastWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }

    var lastMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }

    static func betweenTimeStartToday(endTimestamp: Double) -> String {
        let now = Date()
        let nowTimestamp = now.timeIntervalSince1970
        var betweenTime = Int(endTimestamp - nowTimestamp)
        let day: Int = betweenTime / (3600 * 24)
        betweenTime = betweenTime % (3600 * 24)
        let hour: Int = betweenTime / 3600
        betweenTime = betweenTime % 3600
        let minute: Int = betweenTime / 60
        let second: Int = betweenTime % 60
        return "\(day):\(hour):\(minute):\(second)"
    }

    // Self 날짜기준으로 +N 일 날짜가져오기
    func afterNDay(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self) ?? Date()
    }

    // Self 날짜기준으로 -N 일 날짜가져오기
    func beforeNDay(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -1 * day, to: self) ?? Date()
    }

    // Self 날짜기준으로 -N 달 날짜가져오기
    func beforeNMonth(month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: -1 * month, to: self) ?? Date()
    }

    // 현재 날짜기준으로 -N 일 날짜가져오기
    static func getBeforeNDay(day: Int) -> Date {
        let today = Date()

        return Calendar.current.date(byAdding: .day, value: -1 * day, to: today) ?? Date()
    }

    // diff
    func year(of sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }

    func month(of sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }

    func day(of sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }

    func hour(of sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }

    func minute(of sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
    }

    func second(of sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }

    // 실제 일자 기준으로 계산
    func day(startOfDay sinceDate: Date) -> Int? {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: sinceDate)
        let date2 = calendar.startOfDay(for: self)

        guard let days = calendar.dateComponents([.day], from: date2, to: date1).day else {
            return nil
        }

        return days
    }

    var firstTimeOfDay: Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(from: components) ?? self
    }

    var lastTimeOfDay: Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = 23
        components.minute = 59
        components.second = 59
        return calendar.date(from: components) ?? self
    }

    var milliSeconds: Int64 {
        return Int64((timeIntervalSince1970 * 1000).rounded())
    }

    init(milliSeconds: Int64) {
        self = Date(timeIntervalSince1970: (TimeInterval(milliSeconds) / 1000).rounded())
    }

    var seconds: Int64 {
        return Int64(timeIntervalSince1970.rounded())
    }

    init(seconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(seconds).rounded())
    }
}
