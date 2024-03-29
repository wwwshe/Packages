//
//  UISegmentControl+Extension.swift
//
//
//  Created by jun wook on 3/16/24.
//

import UIKit

public extension UISegmentedControl {
    func removeBorder() {
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: bounds.size)
        setBackgroundImage(
            backgroundImage,
            for: .normal,
            barMetrics: .default
        )
        setBackgroundImage(
            backgroundImage,
            for: .selected,
            barMetrics: .default
        )
        setBackgroundImage(
            backgroundImage,
            for: .highlighted,
            barMetrics: .default
        )

        let deviderImage = UIImage.getColoredRectImageWith(
            color: UIColor.white.cgColor,
            andSize: CGSize(
                width: 1.0,
                height: bounds.size.height
            )
        )
        setDividerImage(
            deviderImage,
            forLeftSegmentState: .selected,
            rightSegmentState: .normal,
            barMetrics: .default
        )
        setTitleTextAttributes(
            [
                .foregroundColor: UIColor.gray,
            ],
            for: .normal
        )
        setTitleTextAttributes(
            [
                .foregroundColor: UIColor(
                    red: 67 / 255,
                    green: 129 / 255,
                    blue: 244 / 255, alpha: 1.0
                ),
            ],
            for: .selected
        )
    }

    func addUnderlineForSelectedSegment(
        color: UIColor = .systemGray,
        height: CGFloat = 2.0
    ) {
        removeBorder()
        let underlineWidth: CGFloat = bounds.size.width / CGFloat(numberOfSegments)
        let underlineHeight: CGFloat = height
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = color
        underline.tag = 1
        addSubview(underline)
    }

    func changeUnderlinePosition() {
        guard let underline = viewWithTag(1) else { return }
        let underlineFinalXPosition = (bounds.width / CGFloat(numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}
