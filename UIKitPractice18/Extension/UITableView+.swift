//
//  UITableView+.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit

extension UITableView {
    func register(_ cellClass: (AnyObject & IsIdentifiable).Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeueReusableCell(_ cellClass: (AnyObject & IsIdentifiable).Type, for indexPath: IndexPath) -> UITableViewCell {
        self.dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath)
    }
}
