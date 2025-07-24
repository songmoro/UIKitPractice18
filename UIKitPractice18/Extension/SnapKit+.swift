//
//  SnapKit+.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

#if canImport(UIKit)
    import UIKit
    public typealias ConstraintView = UIView
#else
    import AppKit
    public typealias ConstraintView = NSView
#endif

import SnapKit

extension [ConstraintView] {
    var snp: [ConstraintViewDSL] {
        map(\.snp)
    }
}

extension [ConstraintViewDSL] {
    func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.forEach { constraintView in
            (constraintView.target as! ConstraintView).snp.makeConstraints(closure)
        }
    }
    
    // TODO: 제일 앞 원소는 지정한 뷰 기준, 이후 원소는 앞 원소 기준 레이아웃 함수
}
