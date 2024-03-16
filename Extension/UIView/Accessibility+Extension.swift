//
//  Accessibility+Extension.swift
//  
//
//  Created by jjw-MAC-PC on 2021/09/29.
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
