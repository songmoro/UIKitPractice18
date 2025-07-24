//
//  MovieCell.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class MovieCell: UITableViewCell, IsIdentifiable {
    let ratingView = RatingView()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "엽문 4: 더 파이널")
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    let dateLabel = UILabel(text: "8888-88-88")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubviews(ratingView, titleLabel, dateLabel)
        
        [ratingView, titleLabel, dateLabel].snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalToSuperview().multipliedBy(0.15)
        }
        
        titleLabel.setContentCompressionResistancePriority(dateLabel.contentCompressionResistancePriority(for: .horizontal) - 1, for: .horizontal)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingView.snp.trailing).offset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(20).priority(.high)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    func update(row: Int, _ movie: Movie) {
        ratingView.ratingLabel.text = "\(row)"
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
    }
}
