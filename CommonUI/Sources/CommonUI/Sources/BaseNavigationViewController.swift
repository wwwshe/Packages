//
//  BaseNavigationViewController.swift
//  
//
//  Created by jun wook on 2023/07/15.
//

import UIKit

open class BaseNavigationViewController: UINavigationController {
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationController?.navigationBar.barTintColor = .gray
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
