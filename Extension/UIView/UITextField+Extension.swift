//
//  UITextField+Extension.swift
//

import UIKit

public extension UITextField {
    func addLeftPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                title: "확인",
                style: .done,
                target: onDone.target,
                action: onDone.action
            ),
        ]
        toolbar.sizeToFit()

        inputAccessoryView = toolbar
    }

    /// nextButtonTap 을 사용하려는 경우 tag를 먼저 셋팅하고 호출 되어야 한다.
    func addNextToolbar(onNext: (target: Any, action: Selector)? = nil) {
        let onNext = onNext ?? (target: self, action: #selector(nextButtonTap))
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        let nextButton = UIBarButtonItem(
            title: "다음",
            style: .done,
            target: onNext.target,
            action: onNext.action
        )
        nextButton.tag = tag
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            nextButton,
        ]
        toolbar.sizeToFit()

        inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { resignFirstResponder() }

    @IBAction func nextButtonTap(sender: Any) {
        if let item = sender as? UIBarButtonItem {
            let tag = item.tag
            nextResponder(viewTag: tag)
        }
    }
}
