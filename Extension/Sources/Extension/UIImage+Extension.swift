//
//  UIImage+Extension.swift
//  
//
//  Created by jun wook on 2023/07/15.
//

import UIKit

public extension UIImage {
    convenience init(name: String, module: Bundle) {
        self.init(named: name, in: module, with: .none)!
    }
}
