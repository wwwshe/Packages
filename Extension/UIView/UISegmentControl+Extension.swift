//
//  UISegmentedControl+Extension.swift
//
//
//  Created by jun wook on 3/16/24.
//

import UIKit

public extension UISegmentedControl {
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(
            backgroundImage,
            for: .normal,
            barMetrics: .default
        )
        self.setBackgroundImage(
            backgroundImage,
            for: .selected,
            barMetrics: .default
        )
        self.setBackgroundImage(
            backgroundImage,
            for: .highlighted,
            barMetrics: .default
        )

        let deviderImage = UIImage.getColoredRectImageWith(
            color: UIColor.white.cgColor,
            andSize: CGSize(
                width: 1.0,
                height: self.bounds.size.height
            )
        )
        self.setDividerImage(
            deviderImage,
            forLeftSegmentState: .selected,
            rightSegmentState: .normal,
            barMetrics: .default
        )
        self.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.gray
            ],
            for: .normal
        )
        self.setTitleTextAttributes(
            [
                .foregroundColor: UIColor(
                    red: 67/255,
                    green: 129/255,
                    blue: 244/255, alpha: 1.0
                )
            ],
            for: .selected
        )
    }

    func addUnderlineForSelectedSegment(
        color: UIColor = .systemGray,
        height: CGFloat = 2.0
    ){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = height
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = color
        underline.tag = 1
        self.addSubview(underline)
    }

    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}
