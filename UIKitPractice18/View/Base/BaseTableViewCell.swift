//
//  BaseTableViewCell.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    @available(*, unavailable, message: "BaseTableViewCell은 코드를 기반으로 함")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}
