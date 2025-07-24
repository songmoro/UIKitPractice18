//
//  UITextField+.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

import UIKit

extension UITextField {
    convenience init(borderStyle: BorderStyle) {
        self.init()
        self.borderStyle = borderStyle
    }
}
