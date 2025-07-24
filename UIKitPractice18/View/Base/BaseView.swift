//
//  BaseView.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

import UIKit

class BaseView: UIView {
    @available(*, unavailable, message: "BaseView는 코드를 기반으로 함")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
