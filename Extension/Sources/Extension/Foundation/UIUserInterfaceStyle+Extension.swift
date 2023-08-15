//
//  UIUserInterfaceStyle+Extension.swift

import Foundation
import UIKit

public extension UIUserInterfaceStyle {
    var styleString: String {
        switch self {
        case .unspecified:
            return "system"
        case .light:
            return "light"
        case .dark:
            return "dark"
        @unknown default:
            return "light"
        }
    }
}
