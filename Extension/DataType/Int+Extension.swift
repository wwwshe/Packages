//
//  Int+Extension.swift
//
//

import Foundation

public extension Int {
    var boolValue: Bool { return self != 0 }

    var twiceNumStr: String {
        let returnValue: String
        if self < 10 {
            returnValue = "0" + String(self)
        } else {
            returnValue = String(self)
        }
        return returnValue
    }

    var krwString: String {
        let format = krNumberFormatter
        format.numberStyle = .decimal
        return format.string(from: NSNumber(value: self)) ?? "0"
    }

    var string: String {
        return String(self)
    }
}

public extension UInt64 {
    var krwString: String {
        let format = krNumberFormatter
        format.numberStyle = .decimal
        return format.string(from: NSNumber(value: self)) ?? "0"
    }

    var string: String {
        return String(self)
    }
}

public extension Int64 {
    var krwString: String {
        let format = krNumberFormatter
        format.numberStyle = .decimal
        return format.string(from: NSNumber(value: self)) ?? "0"
    }

    var string: String {
        return String(self)
    }
}
