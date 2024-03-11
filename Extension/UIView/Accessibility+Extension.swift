//
//  Accessibility+Extension.swift
//  
//
//  Created by jjw-MAC-PC on 2021/09/29.
//  Copyright © 2021 Coinone. All rights reserved.
//

import UIKit

public extension UIView {
    func setAccessibilityID(id: String?) {
        self.accessibilityIdentifier = id
    }
}

public extension UIBarItem {
    func setAccessibilityID(id: String?) {
        self.accessibilityIdentifier = id
    }
}

public extension UIAlertAction {
    func setAccessibilityID(id: String?) {
        self.accessibilityIdentifier = id
    }
}

@available(iOS 13.0, *)
public extension UIMenuElement {
    func setAccessibilityID(id: String?) {
        self.accessibilityIdentifier = id
    }
}

public extension UIImage {
    func setAccessibilityID(id: String?) {
        self.accessibilityIdentifier = id
    }
}
