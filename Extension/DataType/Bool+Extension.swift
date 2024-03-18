//
//  Bool+Extension.swift
//
//

import Foundation

public extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }

    var not: Bool {
        return !self
    }
}
