//
//  StringProtocol+Extension.swift

import Foundation

public extension StringProtocol {
    var data: Data { Data(utf8) }
    var bytes: [UInt8] { [UInt8](utf8) }
}
