//
//  UITableView+Extension.swift
//
//  Created by jun wook on 2023/03/04.
//  Copyright © 2023 jjw. All rights reserved.
//

import UIKit

public extension UITableView {
    func register(cell: UITableViewCell.Type) {
        self.register(cell,
                      forCellReuseIdentifier: cell.className)
    }
    
    func reusableCell<T: UITableViewCell>(cell: T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: cell.className) as? T
    }
}
