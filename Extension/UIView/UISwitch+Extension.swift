//
//  UISwitch+Extension.swift
//
//
//  Created by jjw-Macbook Pro on 2023/04/05.
//

import Foundation
import UIKit

public extension UISwitch {
    func set(width: CGFloat, height: CGFloat) {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
