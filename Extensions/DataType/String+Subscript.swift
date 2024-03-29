//
//  String+Subscript.swift
//
//

import Foundation

public extension String {
    subscript(aRange: NSRange) -> String {
        let start = index(startIndex, offsetBy: aRange.location)
        let end = index(start, offsetBy: aRange.length)
        return String(self[start ..< end])
    }

    /// substring
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: range.lowerBound)
        let idx2 = index(startIndex, offsetBy: range.upperBound)
        return String(self[idx1 ..< idx2])
    }
}
