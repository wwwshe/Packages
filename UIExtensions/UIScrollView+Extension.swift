//
//  UIScrollView+Extension.swift
//
//  Created by jjw-MAC-PC on 2020/11/03.
//

import Foundation
import UIKit

public extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }

    func scrollViewToBottom(animated: Bool = true) {
        let bottomOffset = scrollBottomOffset()

        if bottomOffset.y > 0 {
            setContentOffset(bottomOffset, animated: animated)
        }
    }

    /// 스크롤뷰 중간 위치로 이동
    func scrollToCenterY(animated: Bool = true) {
        let centerY = scrollBottomOffset().y / 2
        setContentOffset(CGPoint(x: 0, y: centerY), animated: animated)
    }

    private func scrollBottomOffset() -> CGPoint {
        return CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
    }

    func animateScrollToTop(duration: TimeInterval, animated: Bool = false, completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.setContentOffset(.zero, animated: animated)
        } completion: { isComplete in
            guard isComplete else { return }
            completion()
        }
    }
}
