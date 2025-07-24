//
//  CircleView.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class CircleView: BaseView {
    let numberLabel = UILabel()
    
    convenience init(width: CGFloat, number: Int) {
        self.init(length: width, number: number)
    }
    
    convenience init(height: CGFloat, number: Int) {
        self.init(length: height, number: number)
    }
    
    convenience init(width: CGFloat) {
        self.init(length: width)
    }
    
    convenience init(height: CGFloat) {
        self.init(length: height)
    }
    
    private init(length: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: length, height: length))
        configureLayout(length)
        
        numberLabel.text = "+"
    }
    
    private init(length: CGFloat, number: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: length, height: length))
        configureLayout(length)
        
        numberLabel.text = number.description
        numberLabel.textColor = .systemBackground
    }
    
    private func configureLayout(_ length: CGFloat) {
        addSubview(numberLabel)
        
        numberLabel.textAlignment = .center
        
        numberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.size.equalTo(CGSize(width: length, height: length))
        }
        
        layer.cornerRadius = length / 2
    }
}
