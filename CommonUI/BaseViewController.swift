//
//  BaseViewController.swift
//
//
//  Created by jun wook on 2023/07/15.
//

import UIKit

open class BaseViewController: UIViewController {
    override public init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
