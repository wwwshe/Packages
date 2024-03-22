//
//  Reactive+UIViewController.swift
//
//
//  Created by jun wook on 3/22/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

public extension Reactive where Base: UIViewController {
    var viewDidLoad: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidLoad))
            .map { $0.first as? Bool ?? false }
    }
    var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    var viewDidAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    var viewWillDisappear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
    }
    
    var viewDidDisappear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
    }
}
