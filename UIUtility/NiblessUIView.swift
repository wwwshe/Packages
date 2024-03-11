//
//  NiblessUIView.swift
//  
//

import UIKit

open class NiblessUIView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }
}
