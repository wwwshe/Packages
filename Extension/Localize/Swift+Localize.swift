//
//  Swift+Localize.swift
//
//
//  Created by jun wook on 3/16/24.
//

import Foundation

public extension String {
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
}
