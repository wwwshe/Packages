//
//  PaddingLabel.swift
//
//  Created by jjw-Macbook Pro on 2022/08/24.
//

import Foundation
import UIKit

public final class PaddingLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0

    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += topInset + bottomInset
        contentSize.width += leftInset + rightInset
        return contentSize
    }

    public init(edgeInset: UIEdgeInsets, frame: CGRect = .zero) {
        topInset = edgeInset.top
        bottomInset = edgeInset.bottom
        leftInset = edgeInset.left
        rightInset = edgeInset.right
        super.init(frame: frame)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError()
    }

    override public func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
}
