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
    
    func safeRemoveObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        switch self.observationInfo {
        case .some:
            self.removeObserver(observer, forKeyPath: keyPath)
        default:
            debugPrint("observer does no not exist")
        }
    }
}
