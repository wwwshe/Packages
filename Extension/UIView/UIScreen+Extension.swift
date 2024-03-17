//
//  UIScreen+Extension.swift
//
//
//  Created by jun wook on 3/17/24.
//

import UIKit

public extension UIScreen {
    static var screen: UIScreen {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return .main
            }
            return windowScene.screen
        } else {
            return UIScreen.main
        }
    }
    
    static var screenSize: CGRect {
        return screen.bounds
    }
    
    static var screenScale: CGFloat {
        return screen.scale
    }
}
