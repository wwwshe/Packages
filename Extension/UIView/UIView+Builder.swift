//
//  UIView+Builder.swift
//  
//
//  Created by jun wook on 2023/07/20.
//

import UIKit

// MARK: - AddSubView Builder
public extension UIView {
    @resultBuilder
    struct AddSubviewBuilder {
        public static func buildBlock(_ components: UIView...) -> [UIView] {
            components
        }
    }
    
    func addSubviews(views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    func addSubviews(@AddSubviewBuilder _ views: () -> [UIView]) {
        let views = views()
        views.forEach { view in
            addSubview(view)
        }
    }
}
