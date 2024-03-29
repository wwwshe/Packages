//
//  UITableViewCell+Extension.swift
//
//  Created by jjw-MAC-PC on 2020/06/26.
//

import Foundation
import UIKit

public extension UITableViewCell {
    static var reuseCellName: String {
        return "\(String(describing: self))"
    }

    static func reuseCell(_ tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellName)
            as? Self
        else {
            fatalError()
        }
        return cell
    }

    static func reuseCell(_ tableView: UITableView, _ indexPath: IndexPath) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellName, for: indexPath)
            as? Self
        else {
            fatalError()
        }
        return cell
    }
}

public extension UITableViewCell {
    var parentTableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
}
