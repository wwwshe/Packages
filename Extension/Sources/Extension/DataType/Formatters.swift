//
//  Formatters.swift
//  
//

import Foundation

public let krDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.korea
    formatter.timeZone = TimeZone.init(abbreviation: "KST")
    return formatter
}()

public let krNumberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = Locale.korea
    return formatter
}()

public let enDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.korea
    formatter.timeZone = TimeZone.init(abbreviation: "UTC")
    return formatter
}()
