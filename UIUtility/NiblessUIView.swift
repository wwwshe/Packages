//
//  NiblessUIView.swift
//
//

import UIKit

open class NiblessUIView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError()
    }
}
