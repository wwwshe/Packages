//
//  NSAttributedString+Extension.swift
//  
//

import Foundation

public extension NSAttributedString {
    
    convenience init(
        format: NSAttributedString,
        args: NSAttributedString...
    ) {
        let mutableNSAttributedString = NSMutableAttributedString(
            attributedString: format
        )
        
        args.forEach { (attributedString) in
            let range = NSString(string: mutableNSAttributedString.string)
                .range(of: "%@")
            mutableNSAttributedString.replaceCharacters(in: range, with: attributedString)
        }
        self.init(attributedString: mutableNSAttributedString)
    }
    
    func size(withConstrainedWidth width: CGFloat) -> CGRect {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox
    }
}
