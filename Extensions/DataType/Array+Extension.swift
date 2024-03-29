//
//  Array+Extension.swift
//
//

import Foundation

public extension Array {
    func item(at index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }

    var isNotEmpty: Bool {
        isEmpty == false
    }
}

public extension Array where Element: Equatable {
    /// Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else { return }
        remove(at: index)
    }
}

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    var json: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}
