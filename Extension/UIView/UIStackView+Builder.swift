//
//  UIStackView+Builder.swift
//
//  Created by jjw-MAC-PC on 2021/11/23.
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

    func addArrangedSubviews(@AddArrangeViewBuilder views: () -> [UIView]) {
        for view in views() {
            addArrangedSubview(view)
        }
    }
}
