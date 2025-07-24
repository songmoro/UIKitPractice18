//
//  SnapKit+.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

import UIKit
import SnapKit

extension [UIView] {
    var snp: [ConstraintViewDSL] {
        map(\.snp)
    }
}

extension [ConstraintViewDSL] {
    func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.forEach { constraintView in
            (constraintView.target as! UIView).snp.makeConstraints(closure)
        }
    }
    
    // TODO: 제일 앞 원소는 지정한 뷰 기준, 이후 원소는 앞 원소 기준 레이아웃 함수
}
