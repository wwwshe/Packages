//
//  BaseNavigationViewController.swift
//
//
//  Created by jun wook on 2023/07/15.
//

import UIKit

open class BaseNavigationViewController: UINavigationController {
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationController?.navigationBar.barTintColor = .gray
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
