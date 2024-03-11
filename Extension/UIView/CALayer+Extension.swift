//
//  CALayer+Extension.swift
//  
//
//  Created by jun wook on 2023/08/15.
//

import UIKit

public extension CALayer {
    /// 특정 위치에만 Border를 그린다.
    @discardableResult
    func addBorder(edge: UIRectEdge, color: UIColor, borderWidth: CGFloat) -> CALayer {

      let border = CALayer()

      switch edge {
      case UIRectEdge.top:
          border.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)

      case UIRectEdge.bottom:
          border.frame = CGRect(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth)

      case UIRectEdge.left:
          border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.height)

      case UIRectEdge.right:
          border.frame = CGRect(x: frame.width - borderWidth, y: 0, width: borderWidth, height: frame.height)

      default: do {}
      }

      border.backgroundColor = color.cgColor

      addSublayer(border)
      return border
   }
}
