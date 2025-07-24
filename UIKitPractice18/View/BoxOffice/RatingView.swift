//
//  RatingView.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class RatingView: BaseView {
    let ratingLabel: UILabel = {
        let label = UILabel(text: "888")
        label.textColor = .systemBackground
        
        return label
    }()
    
    override init() {
        super.init()
        configure()
    }
    
    func configure() {
        addSubview(ratingLabel)
        backgroundColor = .label
        
        ratingLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
