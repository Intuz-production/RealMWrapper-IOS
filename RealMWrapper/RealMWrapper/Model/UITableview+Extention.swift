//
//  UITableview+Extention.swift
//  RealMWrapper
//
//  Created by Intuz on 07/09/21.
//

import Foundation
import UIKit

// swiftlint:disable force_unwrapping

extension UITableView {

    func register<T: UITableViewCell>(nibWithCalss name: T.Type) {
        let nib = UINib(nibName: String(describing: name), bundle: Bundle(for: T.self))
        self.register(nib, forCellReuseIdentifier: String(describing: name))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        return (self.dequeueReusableCell(withIdentifier: String(describing: name), for:indexPath) as? T)!
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterViewWithClass name:T.Type) {
        let nib = UINib(nibName: String(describing: name), bundle: Bundle(for: T.self))
        self.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        return (self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T)!
    }
}
