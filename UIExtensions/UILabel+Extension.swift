//
//  UILabel+Extension.swift
//
//
//  Created by jun wook on 2023/07/15.
//

import UIKit

public extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat) {
        guard let text = text else { return }

        let attr = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let range = NSRange(location: 0, length: attr.length)

        attr.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: range
        )
        attributedText = attr
    }
}
