//
//  UICollectionViewCell+Extension.swift
//  
//
//  Created by jjw-MAC-PC on 2021/10/26.
//

import UIKit

public extension UICollectionViewCell {
    static var reuseCellName: String {
        return "\(String(describing: self))"
    }
    
    static func reuseCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> Self {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.reuseCellName,
                                                            for: indexPath) as? Self else {
           fatalError()
        }
        return cell
    }
}
