//
//  UIStackView+Extension.swift
//
//  Created by jjw-MAC-PC on 2021/11/23.
//  Copyright © 2021 Coinone. All rights reserved.
//

import UIKit

public extension UIStackView {
    /// subview 전체 삭제
    func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}

// MARK: AddArrangeViewBuilder
public extension UIStackView {
    @resultBuilder
    struct AddArrangeViewBuilder {
        public static func buildBlock(_ components: UIView...) -> [UIView] {
            components
        }
    }
    
    func addArrangedSubviews(_ views: () -> [UIView]) {
        views().forEach { view in
            addArrangedSubview(view)
        }
    }
}
