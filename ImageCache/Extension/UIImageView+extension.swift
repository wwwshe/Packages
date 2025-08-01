//
//  UIImageView+extension.swift
//
//
//  Created by jun wook on 3/29/24.
//

import Extensions
import UIKit

public extension UIImageView {
    func setImageUrl(
        _ url: String,
        completion: (() -> Void)? = nil
    ) {
        ImageCacheManager.shared.getImage(url) { image in
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion?()
            }
        }
    }
}
