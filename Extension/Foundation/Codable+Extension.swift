//
//  Codable+Extension.swift

import Foundation

public extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let params = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return params
    }
}
