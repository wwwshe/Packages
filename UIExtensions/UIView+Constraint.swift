//
//  UIView+Constraint.swift
//
//
//  Created by jun wook on 3/29/24.
//

import UIKit

extension UIView {
    func setTranslates() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UIView {
    func edge() {
        guard let superview else { return }
        setTranslates()
        leadingAnchor.constraint(
            equalTo: superview.leadingAnchor
        ).isActive = true
        trailingAnchor.constraint(
            equalTo: superview.trailingAnchor
        ).isActive = true
        topAnchor.constraint(
            equalTo: superview.topAnchor
        ).isActive = true
        bottomAnchor.constraint(
            equalTo: superview.bottomAnchor
        ).isActive = true
    }

    func leading(
        _ to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        constant: CGFloat = 0
    ) {
        setTranslates()
        leadingAnchor.constraint(
            equalTo: to, constant: constant
        ).isActive = true
    }

    func trailing(
        _ to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        constant: CGFloat = 0
    ) {
        setTranslates()
        trailingAnchor.constraint(
            equalTo: to, constant: constant
        ).isActive = true
    }

    func top(
        _ to: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        constant: CGFloat = 0
    ) {
        setTranslates()
        topAnchor.constraint(
            equalTo: to, constant: constant
        ).isActive = true
    }

    func bottom(
        _ to: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        constant: CGFloat = 0
    ) {
        setTranslates()
        bottomAnchor.constraint(
            equalTo: to, constant: constant
        ).isActive = true
    }

    func centerX(
        _ to: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        constant: CGFloat = 0
    ) {
        setTranslates()
        centerXAnchor.constraint(
            equalTo: to, constant: constant
        ).isActive = true
    }

    func centerY(
        _ to: NSLayoutAnchor<NSLayoutYAxisAnchor>,
        constant: CGFloat = 0
    ) {
        setTranslates()
        centerYAnchor.constraint(
            equalTo: to, constant: constant
        ).isActive = true
    }
}
