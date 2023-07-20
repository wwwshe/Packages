//
//  BaseViewController.swift
//  
//
//  Created by jun wook on 2023/07/15.
//

import UIKit

open class BaseViewController: UIViewController {
    public override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = .white
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
