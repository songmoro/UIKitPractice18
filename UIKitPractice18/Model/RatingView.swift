//
//  RatingView.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class RatingView: UIView {
    let ratingLabel: UILabel = {
        let label = UILabel(text: "888")
        label.textColor = .systemBackground
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(ratingLabel)
        backgroundColor = .label
        
        ratingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
