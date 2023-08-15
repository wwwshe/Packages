//
//  PaddingLabel.swift
//
//  Created by jjw-Macbook Pro on 2022/08/24.
//  Copyright © 2022 Coinone. All rights reserved.
//

import Foundation
import UIKit

public final class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    public override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    public init(edgeInset: UIEdgeInsets, frame: CGRect = .zero) {
        self.topInset = edgeInset.top
        self.bottomInset = edgeInset.bottom
        self.leftInset = edgeInset.left
        self.rightInset = edgeInset.right
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
}

