//
//  UIView+.swift


import UIKit
import SnapKit

public extension UIView {
    var getWidth: CGFloat {
        return self.frame.width
    }
    
    var getHeight: CGFloat {
        return self.frame.height
    }
    
    func shake() {
        shakeView(offset: 10.0)
    }
    
    func shakeView(offset: CGFloat) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.duration = 0.08
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = (self.center.x - offset)
        animation.toValue = (self.center.x + offset)
        self.layer.add(animation, forKey: "position.x")
    }
    
    func setShadow(opacity: Float = 0.15, radius: CGFloat = 24) {
        setShadow(opacity: opacity, radius: radius, color: UIColor.black.cgColor)
    }
    
    func setShadow(opacity: Float = 0.15, radius: CGFloat = 24, color: CGColor) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity // 진하기
        self.layer.shadowOffset = CGSize.zero // 자상 -> 우하
        self.layer.shadowRadius = radius / 2.0 // 너비
    }
    
    // auto layout 이후에 진행해야된다.
    func setRoundCorner(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    // 그라데이션
    func gradation(startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colors
        self.layer.addSublayer(gradient)
    }
    
    class func duration(distance: CGFloat) -> TimeInterval {
        return TimeInterval(abs(distance)*(0.3/281.0))
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// 요걸 써야 뷰 하단이 안짤림
    func newRoundCorners(masks: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = masks
    }
}

public extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint? {
        
        if let item1 = self.firstItem {
            return NSLayoutConstraint(
                item: item1,
                attribute: self.firstAttribute,
                relatedBy: self.relation,
                toItem: self.secondItem,
                attribute: self.secondAttribute,
                multiplier: multiplier,
                constant: self.constant
            )
        } else {
            return nil
        }
    }
}

public extension UIView {
    /// copy snapShot View
    func copySnapView() -> UIView {
        let isHidden = self.isHidden
        self.isHidden = false
        let viewCopy = self.snapshotView(afterScreenUpdates: true)
        self.isHidden = isHidden
        return viewCopy ?? self
    }
    
    func takeSnapshot() -> UIImage? {
        let view = UIView(frame: self.bounds)
        view.addSubview(self)
        
        self.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, UIScreen.main.scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func rootView() -> UIView {
        return superview?.rootView() ?? superview ?? self
    }
    /// 부모뷰 중 hidden 처리된게 있는지
    /// - Parameters:
    ///   - accessDepth: 접근한 depth
    ///   - depth: 검사할 부모 뷰 뎁스
    /// - Returns: true : 숨김 상태
    func superviewIsHidden(accessDepth: Int = 0, depth: Int = 3) -> Bool {
        guard accessDepth < depth else { return false }
        guard let sview = superview else { return false }
        if sview.isHidden {
            return true
        } else {
            return sview.superviewIsHidden(accessDepth: accessDepth + 1)
        }
        
    }
    
    /// tag + 1 의 responder를 활성화 시킨다.
    /// - Parameter viewTag: view base가 아닌 컴포넌트의 tag를 받음
    func nextResponder(viewTag: Int? = nil) {
        let currentTag = viewTag ?? self.tag
        if let view = self.rootView().viewWithTag(currentTag + 1), view.canBecomeFirstResponder {
            view.becomeFirstResponder()
        } else {
            self.endEditing(true)
        }
    }
}

/// animation
public extension UIView {
    func slideIn(direction: AnimationDirection = .bottomToTop, duration: TimeInterval = 0.5, delay: TimeInterval = 0) {
        let slideTransition = CATransition()
        slideTransition.type = CATransitionType.push
        slideTransition.duration = duration
        slideTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideTransition.fillMode = CAMediaTimingFillMode.removed
        
        switch direction {
        case .bottomToTop:
            slideTransition.subtype = CATransitionSubtype.fromTop
        case .leftToRight:
            slideTransition.subtype = CATransitionSubtype.fromLeft
        case .rightToLeft:
            slideTransition.subtype = CATransitionSubtype.fromRight
        case .topToBottom:
            slideTransition.subtype = CATransitionSubtype.fromBottom
        }
        
        self.layer.add(slideTransition, forKey: nil)
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }) { [weak self] (_) in
            self?.removeFromSuperview()
        }
    }
    
}

public extension UIView {
    
    func fadeIn(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func rotate(angle: CGFloat, startAngle: Double? = nil) {
        if let startAngle = startAngle {
            transform = CGAffineTransform(rotationAngle: startAngle)
        }
        let radians = angle / 180.0 * CGFloat.pi
        self.transform = transform.rotated(by: radians)
    }
}

public enum AnimationDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
}

public extension UIView {
    /// subView 전부 지우기
    func removeAll() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

public extension UIResponder {
    
    /// 현재뷰의 부모뷰컨트롤러
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
