//
//  NSObject+Extension.swift
//
//  Created by jun wook on 2023/03/04.
//  Copyright © 2023 jjw. All rights reserved.
//

import Foundation

public extension NSObject {
    static var className: String {
        String(describing: self)
    }
}
