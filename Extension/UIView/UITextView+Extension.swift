//
//  UITextView+Extension.swift

import UIKit

public extension UITextView {
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
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
            )
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    
    func addNextToolbar(onNext: (target: Any, action: Selector)? = nil) {
        let onNext = onNext ?? (target: self, action: #selector(nextButtonTap))
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        let nextButton = UIBarButtonItem(
            title: "다음",
            style: .done,
            target: onNext.target,
            action: onNext.action
        )
        nextButton.tag = self.tag
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            nextButton
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    
    @IBAction func nextButtonTap(sender: Any) {
        if let item = sender as? UIBarButtonItem {
            let tag = item.tag
            self.nextResponder(viewTag: tag)
        }
    }
}
